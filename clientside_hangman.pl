#!/usr/bin/python3

print("Content-type: text/html\n\n")

words = ["tomato", "banana", "nectarine", "lettuce", "avocado", "eggplant"]

import cgi, random
data = cgi.FieldStorage()

(secret, mask, action, feedback, collectLetter) = ("", "", "", "", "")

if "secret" in data: secret = data["secret"].value
if "mask" in data:  mask   = data["mask"].value

if (secret, mask) == ("", ""):
  secret = random.choice(words)
  mask = "-" * len(secret)
  feedback = "The secret word is %s <p> Your current mask is: %s " % (secret, mask)
  collectLetter = "Type a letter here: <input type=text name=letter><p>"
else:
  if "action" in data: action = data["action"].value
  if "letter" in data: letter = data["letter"].value
  if letter in secret:
    for i in range(len(secret)):
      if secret[i]==letter:
        mask=mask[:i] + letter + mask[i+1:]
  if secret == mask:
    feedback = "That was the word: " + secret + "! Ready for a new game? "
    (secret, mask) = ("", "")
  else:
    feedback = "The secret word is %s <p> Your current mask is: %s " % (secret, mask)
    collectLetter = "Type a letter here: <input type=text name=letter><p>"

print (
"""
<form>
  %s <p>

  %s
  <input type=hidden name=secret value=%s>
  <input type=hidden name=mask value=%s>
  Please press <input type=submit name=action value=Proceed> to move on.
</form>
"""
 % (feedback, collectLetter, secret, mask))
