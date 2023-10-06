from wsgiref.simple_server import make_server

PORT = 5000

# A relatively simple WSGI application. It's going to print out the
# environment dictionary after being updated by setup_testing_defaults
def simple_app(environ, start_response):
    status = '200 OK'
    headers = [('Content-type', 'text/plain; charset=utf-8')]

    start_response(status, headers)

    method = environ['REQUEST_METHOD']
    uri = environ['PATH_INFO']
    return [
        f'Processing {method} to {uri}'.encode('utf-8')
    ]

with make_server('', PORT, simple_app) as httpd:
    print(f'Serving on port {PORT}...')
    httpd.serve_forever()
