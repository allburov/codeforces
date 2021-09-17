def read_input():
    with open('threesum.in') as input_:
        s = int(input_.readline())
        _, *num1 = list(map(int, input_.readline().split()))
        _, *num2 = list(map(int, input_.readline().split()))
        _, *num3 = list(map(int, input_.readline().split()))
    return s, num1, num2, num3


def findMiddle(numsA, numsB, S):
    nA = len(numsA)
    nB = len(numsB)
    i, j = 0, nB - 1
    answers = []
    while i < nA and j >= 0:
        sumN = numsA[i][0] + numsB[j][0]
        if sumN == S:
            answers.append((numsA[i][1], numsB[j][1]))
            j-=1
        elif sumN < S:
            i += 1
        else:
            j -= 1

    if not answers:
        return None
    answers.sort()
    return answers[0]


# num, pos


def task(s, nums1, nums2, nums3):
    minSum = min(nums2) + min(nums3)
    maxSum = max(nums2) + max(nums3)
    nums2 = [(num, i) for i, num in enumerate(nums2)]
    nums2.sort()
    nums3 = [(num, i) for i, num in enumerate(nums3)]
    nums3.sort()
    for i, num in enumerate(nums1):
        find = s - num

        if find > maxSum or find < minSum:
            continue

        res = findMiddle(nums2, nums3, S=s - num)
        if res:
            return i, res[0], res[1]
    return [-1]


if __name__ == "__main__":
    args = read_input()
    res = task(*args)
    print(" ".join(map(str, res)))
