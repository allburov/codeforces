"""
https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
"""
from typing import List


class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        n = len(prices)
        minPrice = [float("inf")] * n
        maxPrice = [-1] * n
        for i in range(n):
            price = prices[i]
            minPrice[i] = price if i == 0 else min(minPrice[i-1], price)
        for i in range(n-1, -1, -1):
            maxPrice[i] = prices[i] if i == n-1 else max(maxPrice[i+1], prices[i])

        profit = 0
        for i in range(n):
            profit = max(profit, maxPrice[i] - minPrice[i])

        return profit

assert Solution().maxProfit([7, 1, 5, 3, 6, 4]) == 5
assert Solution().maxProfit([7, 6, 4, 3, 1]) == 0
