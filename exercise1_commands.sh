#!/bin/bash
# ============================================================
# Exercise 1 — Analysis of access-1.log
# Analyst: Ateke Tamunonengieofori
# Environment: Kali Linux
# ============================================================

# Q1: How many GET requests were logged?
grep -c '"GET ' access-1.log
# Answer: 127

# Q2: How many unique status codes were returned by the server?
awk '{print $9}' access-1.log | sort -u | wc -l
# Answer: 6

# Q3: How many HTTP tunneling attempts were made? (CONNECT method)
grep -c '"CONNECT ' access-1.log
# Answer: 10

# Q4: How many entries contain raw binary data?
grep -c '[^[:print:]]' access-1.log
# Answer: 0

# Q5: How many unique user agents (excluding empty or missing)?
awk -F'"' '{print $6}' access-1.log | grep -vE '^-|^$' | sort -u | wc -l
# Answer: 55

# Q6: How many requests were made by Firefox?
grep -c 'Firefox' access-1.log
# Answer: 11
