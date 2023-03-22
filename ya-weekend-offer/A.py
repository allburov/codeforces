import math
from decimal import Decimal


def read_input(input):
    w = int(input())
    nk = input()
    n, k = nk.split(" ")
    n, k = int(n), int(k)
    photos = []
    for _ in range(n):
        line = input()
        wi, hi = line.split("x")
        wi, hi = int(wi), int(hi)
        photos.append((wi, hi))
    assert len(photos) == n
    return w, n, k, photos

def resize(w, wi, hi):
    size = Decimal(hi) * Decimal(w) / Decimal(wi)
    return math.ceil(size)

def solver(w, n, k, photos):
    photos_new_w = sorted(resize(w, wi, hi) for wi, hi in photos)
    min_k = sum(photos_new_w[:k])
    max_k = sum(photos_new_w[-k:])
    return min_k, max_k




def input_test(string):
    lines = string.splitlines()
    i = -1

    def _call():
        nonlocal i
        i = i + 1
        return lines[i]

    return _call


def main(string=None):
    """
    Для чтения входных данных необходимо получить их
    из стандартного потока ввода (sys.stdin).
    Данные во входном потоке соответствуют описанному
    в условии формату. Обычно входные данные состоят
    из нескольких строк.
    Можно использовать несколько методов:
    * input() -- читает одну строку из потока без символа
    перевода строки;
    * sys.stdin.readline() -- читает одну строку из потока,
    сохраняя символ перевода строки в конце;
    * sys.stdin.readlines() -- вернет список (list) строк,
    сохраняя символ перевода строки в конце каждой из них.
    Чтобы прочитать из строки стандартного потока:
    * число -- int(input()) # в строке должно быть одно число
    * строку -- input()
    * массив чисел -- map(int, input().split())
    * последовательность слов -- input().split()
    Чтобы вывести результат в стандартный поток вывода (sys.stdout),
    можно использовать функцию print() или sys.stdout.write().
    Возможное решение задачи "Вычислите сумму чисел в строке":
    print(sum(map(int, input().split())))
    """
    # input = input
    input_ = input_test(string) if string else input
    args = read_input(input=input_)
    min_k, max_k = solver(*args)
    print(min_k)
    print(max_k)
    return min_k, max_k

A1 = """2000
5 3
1000x1000
1000x1500
640x930
640x1500
3000x1000"""

A2= """1000
5 5
1404x1386
1132x1110
1061x1801
1022x1519
1529x1003"""

A3 = """4096
2 1
640x4096
4096x640"""
# assert main(A1) == (5574, 10595)
# assert main(A2) == (5810,5810)
# assert main(A3) == (640,26215)

if __name__ == '__main__':
    main()
