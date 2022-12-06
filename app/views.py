from django.shortcuts import render
from django.http import JsonResponse

import time

import redis



cache = redis.Redis(host='redis', port=6379)

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

def hello(request):
    count = get_hit_count()
    return JsonResponse(f"Bonjour de Docker! J'ai ete vu {count} fois", safe=False)

