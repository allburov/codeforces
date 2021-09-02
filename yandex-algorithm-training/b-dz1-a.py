def read_input():
    with open('input.txt') as input_:
        exit_code = input_.readline()[:-1]
        interactor = input_.readline()[:-1]
        checker = input_.readline()[:-1]
    return map(int, [exit_code, interactor, checker])


def task(exit_code, interactor, checker):
    # Если интерактор выдал вердикт 0, итоговый вердикт равен 3 в случае, если программа завершилась с ненулевым кодом, и вердикту чекера в противном случае.
    if interactor == 0:
        return 3 if exit_code != 0 else checker
    # Если интерактор выдал вердикт 1, итоговый вердикт равен вердикту чекера.
    if interactor == 1:
        return checker
    # Если интерактор выдал вердикт 4, итоговый вердикт равен 3 в случае, если программа завершилась с ненулевым кодом, и 4 в противном случае.
    if interactor == 4:
        return 3 if exit_code != 0 else 4
    # Если интерактор выдал вердикт 6, итоговый вердикт равен 0.
    if interactor == 6:
        return 0
    # Если интерактор выдал вердикт 7, итоговый вердикт равен 1.
    if interactor == 7:
        return 1
    # В остальных случаях итоговый вердикт равен вердикту интерактора.
    return interactor


assert task(0,0,0) == 0
assert task(-1,0,1) == 3
assert task(42,1,6) == 6
assert task(44,7,4) == 1
assert task(1,4,0) == 3
assert task(-3,2,4) == 2

if __name__ == "__main__":
    exit_code, interactor, checker = read_input()
    answer = task(exit_code, interactor, checker)
    print(answer)
