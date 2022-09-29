import signal, time

def handler(signum, time):
    print("\nI got a SIGINT, but I am not stopping")

# 当捕捉到SIGINT信号(即^C)时，进程并不会退出，此时需要通过(^\)退出
signal.signal(signal.SIGINT, handler)
i = 0
while True:
    time.sleep(.1)
    print("\r{}".format(i), end="")
    i += 1