#!/usr/bin/python3

import random
(before, mistake) = ("", 0)
word = random.choice(['python', 'wonderful', 'eggplant', 'guava'])
mask = '-' * len(word)
while True:
    letter = input(mask + "> ")
    if letter in word:
        for i in range(len(word)):
            if word[i] == letter: mask = mask[:i] + letter + mask[i+1:]
        if mask == word:
            print("Congratulations.")
            break
    else:
        if letter in before:
            print("You've tried", letter, "before and I told you it's not a good choice!")
        else:
            mistake += 1
            before = before + letter
            if mistake >= 6:
                print("You lost")
                print("The secret word was", word)
                break
