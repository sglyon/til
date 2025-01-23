---
date: '2025-01-23T09:59:09-05:00'
draft: false
title: 'FastAPI Dependencies and Profiling'
---


I was building a FastAPI application to serve a PII detector system build using [presidio](https://microsoft.github.io/presidio/)

I was loading the model like this:

```python
from presidio_analyzer import AnalyzerEngine

from presidio_analyzer.nlp_engine import NlpEngineProvider
from my_app import get_request_analyzer, OpenAPIURLMatcher, RequestAnalyzer
from fastapi import Depends, FastAPI

app = FastAPI()

def get_presidio_analyzer() -> AnalyzerEngine:
    nlp_engine = NlpEngineProvider(nlp_configuration=NLP_CONFIG).create_engine()
    return AnalyzerEngine(nlp_engine=nlp_engine)


def get_request_analyzer(
    analyzer: AnalyzerEngine = Depends(get_presidio_analyzer),
) -> RequestAnalyzer:
    url_matcher = OpenAPIURLMatcher()
    return RequestAnalyzer(analyzer=analyzer, url_matcher=url_matcher)

@app.post("/my-endpoint-here")
def post_data_types(
    request: DataTypeRequest,
    analyzer: RequestAnalyzer = Depends(get_request_analyzer),
) -> DataTypeResponse:
    ...
```

Notice that I was using the [FastAPI dependnency injection system](https://fastapi.tiangolo.com/tutorial/dependencies/)

I assumed that the dependency injection system would load the dependency once on demand and then use for subsequent requests. This turned out not be true.

How did I figure it out? I used [pyinstrument](https://github.com/joerick/pyinstrument)  to profile my FastAPI application. To set it up I added this to my main.py file:

```python
# move this to config
PROFILING = True

if PROFILING:
    from fastapi import Request
    from fastapi.responses import HTMLResponse
    from pyinstrument import Profiler

    @app.middleware("http")
    async def profile_request(request: Request, call_next):
        profiling = request.query_params.get("profile", False)
        if profiling:
            profiler = Profiler(async_mode="enabled", interval=0.001)
            profiler.start()
            await call_next(request)
            profiler.stop()
            return HTMLResponse(profiler.output_html())
        else:
            return await call_next(request)
```

Then I ran my application and made a request to it with the query parameter `?profile=1`. The output showed that the `get_presidio_analyzer` function was being called on every request. Furthermore the call to load the model was taking over 80% of the total runtime of the request.

To fix it I just created a global variable for my `RequestAnalyzer` and reference that from within `post_data_types`
