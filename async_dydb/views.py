from django.http import HttpResponse
import time, asyncio

# ----------------------------------------------home views------------------------------------------

def home_view(request):
    return HttpResponse('Hello world')

# -------------------------------------------timer based method--------------------------

def get_timer01():
    print('prepare to get the timer01...')
    time.sleep(2)
    print('after the timer01 complete')

def get_timer02():
    print('prepare to get the timer02...')
    time.sleep(5)
    print('after the timer02 complete')

# --------async methods--------------------------

# Note: for other async methods we have to use "async"
async def get_timer01_async():
    print('prepare to get the timer01... (async)')
    await asyncio.sleep(2)
    print('after the timer01 complete (async)')

async def get_timer02_async():
    print('prepare to get the timer02... (async)')
    await asyncio.sleep(5)
    print('after the timer02 complete (async)')

# --------------------------------------------timer based views-----------------------
def main_view(request):
    start_time = time.time()
    get_timer01()
    get_timer02()
    total = (time.time()-start_time)
    print('total: ', total)
    return HttpResponse('sync - view')
    # total:  7.0053699016571045

async def main_view_async(request):
    start_time = time.time()
    # task1 = asyncio.ensure_future(get_timer01_async())
    # task2 = asyncio.ensure_future(get_timer02_async())
    # await asyncio.wait([task1, task2])
    await asyncio.gather(get_timer01_async(), get_timer02_async())
    total = (time.time()-start_time)
    print('total: ', total)
    return HttpResponse('async')

    # total:  5.002896070480347