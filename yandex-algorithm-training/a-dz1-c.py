def read_input():
    nums = []
    with open('input.txt') as input_:
        for i in range(3):
            num = list(map(int, input_.readline().split()))
            nums.extend(num)
    return (nums,)


X = 1
O = 2

DIFF_IN_GAME = (0, 1)
DIFF_WINNER_X = (1,)
DIFF_WINNER_O = (0,)


def task(nums):
    numberX = nums.count(X)
    numberO = nums.count(O)
    winner = None
    variants = [
        # Горизонтальные
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        # Вертикальные
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        # диаг
        [0, 4, 8],
        [2, 4, 6],
    ]
    for variant in variants:
        if nums[variant[0]] == nums[variant[1]] == nums[variant[2]]:
            winner_ = nums[variant[0]]
            if winner_ in (X, O):
                if winner and winner != winner_:
                    return "NO"
                winner = winner_

    if not winner:
        diff = DIFF_IN_GAME
    else:
        diff = DIFF_WINNER_X if winner == X else DIFF_WINNER_O

    if (numberX - numberO) in diff:
        return "YES"
    return "NO"


if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(answer)
