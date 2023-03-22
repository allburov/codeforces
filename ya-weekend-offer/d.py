import heapq
import queue
from itertools import groupby


def read_input():
    with open('input.txt') as input_:
        n, m, k = tuple(map(int, input_.readline().split()))
        tasks = []
        for i in range(n):
            s, q, t = tuple(map(int, input_.readline().split()))
            tasks.append(Task(i, s, q, t))
    return m, k, tasks


def Task(i, s, q, t):
    return dict(
        i=i,
        seconds_to_queue=s,
        queue_number=q,
        time_to_execute=t,
    )


class Q(queue.Queue):
    def __init__(self, i):
        self.i = i
        self.last_seconds_we_get_task = 0
        super().__init__()


class QueueOfQ:
    def __init__(self, k):
        self.heap = []
        self.queues = [Q(i) for i in range(0, k)]
        self.in_heap = set()

    def has_tasks(self):
        return bool(self.in_heap)

    def add_task(self, task):
        q = self.queues[task['queue_number'] - 1]
        q.put(task)
        if q.i not in self.in_heap:
            heapq.heappush(self.heap, (q.last_seconds_we_get_task, q.i, q))
            self.in_heap.add(q.i)

    def get_task(self, second):
        if not self.heap:
            return

        _, _, q = heapq.heappop(self.heap)
        q.last_seconds_we_get_task = second
        task = q.get()
        if q.empty():
            self.in_heap.remove(q.i)
        else:
            heapq.heappush(self.heap, (q.last_seconds_we_get_task, q.i, q))
        return task


def resolve(m, k, tasks):
    tick = 1
    result = {}
    tasks_per_seconds = {key: list(value) for key, value in groupby(tasks, key=lambda task: task['seconds_to_queue'])}
    del tasks
    queue_of_queues = QueueOfQ(k)
    executors_heap = [i for i in range(1, m + 1)]
    heapq.heapify(executors_heap)
    executor_make_free_on_second = {}

    while queue_of_queues.has_tasks() or tasks_per_seconds:
        if tick in tasks_per_seconds:
            tasks = tasks_per_seconds.pop(tick)
            for t in tasks:
                queue_of_queues.add_task(t)

        while executors_heap:
            if not queue_of_queues.has_tasks():
                break
            task = queue_of_queues.get_task(tick)
            executor = heapq.heappop(executors_heap)
            seconds_to_free = tick + task['time_to_execute'] - 1
            if seconds_to_free in executor_make_free_on_second:
                executor_make_free_on_second[seconds_to_free].append(executor)
            else:
                executor_make_free_on_second[seconds_to_free] = [executor]
            result[task['i']] = (executor, tick)

        if tick in executor_make_free_on_second:
            for executor in executor_make_free_on_second[tick]:
                heapq.heappush(executors_heap, executor)
        tick += 1

    return result


def main():
    m, k, tasks = read_input()
    result = resolve(m, k, tasks)
    for i in range(len(tasks)):
        value = result[i]
        print(f"{value[0]} {value[1]}")


if __name__ == "__main__":
    main()
