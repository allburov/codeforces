"""
https://leetcode.com/problems/smallest-string-with-a-given-numeric-value/
"""


class Solution:
    def getSmallestString(self, n: int, k: int) -> str:
        left = n
        numbers = []
        while k:
            left = left - 1
            number = min(k - left, 26)
            k -= number
            numbers.append(number)
        letters = [chr(96 + number) for number in numbers]
        letters.reverse()
        return "".join(letters)


assert Solution().getSmallestString(3, 3) == "aaa"
assert Solution().getSmallestString(3, 27) == "aay"
assert Solution().getSmallestString(5, 73) == "aaszz"
