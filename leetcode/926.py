"""
https://leetcode.com/problems/flip-string-to-monotone-increasing/
"""


class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        n = len(s)
        dp = [[0, 0] for _ in range(n+1)]
        for j in range(n):
            i = n - j - 1
            dp[i][0] = int(s[i]) + min(dp[i+1][0], dp[i+1][1])
            dp[i][1] = (0 if s[i] == "1" else 1) + dp[i + 1][1]
        return min(dp[0][0], dp[0][1])


assert Solution().minFlipsMonoIncr("00110") == 1
assert Solution().minFlipsMonoIncr("010110") == 2
assert Solution().minFlipsMonoIncr("00011000") == 2
assert Solution().minFlipsMonoIncr("101100") == 3
