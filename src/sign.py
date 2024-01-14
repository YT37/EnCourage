import base64

alphabets = {
    "a": "../assets/signs/alphabets/A.png",
    "b": "../assets/signs/alphabets/B.png",
    "c": "../assets/signs/alphabets/C.png",
    "d": "../assets/signs/alphabets/D.png",
    "e": "../assets/signs/alphabets/E.png",
    "f": "../assets/signs/alphabets/F.png",
    "g": "../assets/signs/alphabets/G.png",
    "h": "../assets/signs/alphabets/H.png",
    "i": "../assets/signs/alphabets/I.png",
    "j": "../assets/signs/alphabets/J.png",
    "k": "../assets/signs/alphabets/K.png",
    "l": "../assets/signs/alphabets/L.png",
    "m": "../assets/signs/alphabets/M.png",
    "n": "../assets/signs/alphabets/N.png",
    "o": "../assets/signs/alphabets/O.png",
    "p": "../assets/signs/alphabets/P.png",
    "q": "../assets/signs/alphabets/Q.png",
    "r": "../assets/signs/alphabets/R.png",
    "s": "../assets/signs/alphabets/S.png",
    "t": "../assets/signs/alphabets/T.png",
    "u": "../assets/signs/alphabets/U.png",
    "v": "../assets/signs/alphabets/V.png",
    "w": "../assets/signs/alphabets/W.png",
    "x": "../assets/signs/alphabets/X.png",
    "y": "../assets/signs/alphabets/Y.png",
    "z": "../assets/signs/alphabets/Z.png",
}

# TODO: Numbers
# nums = {
#     "1": alpha["a"],
#     "2": alpha["b"],
#     "3": alpha["c"],
#     "4": alpha["d"],
#     "5": alpha["e"],
#     "6": alpha["f"],
#     "7": alpha["g"],
#     "8": alpha["h"],
#     "9": alpha["i"],
#     "0": alpha["j"],
# }


class Character:
    def __init__(self, character, sign):
        self.character = character

        with open(sign, "rb") as f:
            self.sign = base64.b64encode(f.read()).decode("ascii")

    def __str__(self):
        return self.character


class Word:
    def __init__(self, word):
        self.word = word
        self.characters = []

        self.convert()

    def convert(self):
        characters = list(self.word)

        for i in range(len(characters)):
            character = characters[i]

            if character in list(alphabets):
                self.characters.append(
                    Character(character.lower(), alphabets[character.lower()])
                )

            # elif character in list(numbers):
            #     self.characters.append(Sign(character, numbers[character]))

            else:
                print(f"{self.word} doesn't have any match!")

    def __str__(self):
        caption = ""

        for sign in self.characters:
            caption += str(sign)
            caption += "\n\n"

        return caption

    def translate(self):
        return [
            [character.sign for character in self.characters],
            [character.character for character in self.characters],
        ]


class Sign:
    def __init__(self, sentence):
        self.sentence = sentence
        self.words = [Word(word) for word in sentence.split()]

    def translate(self):
        out = []
        count = 0

        for i in range(len(self.words)):
            word = self.words[i]
            w = word.translate()

            out.append(w)

        for word in out:
            sign, caption = word

            for i in range(len(sign)):
                yield (sign[i], caption[i])
