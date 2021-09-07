def read_input():
    nums = []
    with open('input.txt') as input_:
        for i in range(3):
            num = list(map(int, input_.readline().split()))
            nums.extend(num)
    return (nums,)


def task(nums):
    numberO = nums.count(1)
    numberX = nums.count(2)
    return "YES" if numberO - numberX <= 1 else "NO"

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(answer)
