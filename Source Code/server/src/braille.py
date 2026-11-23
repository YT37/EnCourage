alphabets = {
    "a": [1, 0, 0, 0, 0, 0],
    "b": [1, 1, 0, 0, 0, 0],
    "c": [1, 0, 0, 1, 0, 0],
    "d": [1, 0, 0, 1, 1, 0],
    "e": [1, 0, 0, 0, 1, 0],
    "f": [1, 1, 0, 1, 0, 0],
    "g": [1, 1, 0, 1, 1, 0],
    "h": [1, 1, 0, 0, 1, 0],
    "i": [0, 1, 0, 1, 0, 0],
    "j": [0, 1, 0, 1, 1, 0],
    "k": [1, 0, 1, 0, 0, 0],
    "l": [1, 1, 1, 0, 0, 0],
    "m": [1, 0, 1, 1, 0, 0],
    "n": [1, 0, 1, 1, 1, 0],
    "o": [1, 0, 1, 0, 1, 0],
    "p": [1, 1, 1, 1, 0, 0],
    "q": [1, 1, 1, 1, 1, 0],
    "r": [1, 1, 1, 0, 1, 0],
    "s": [0, 1, 1, 1, 0, 0],
    "t": [0, 1, 1, 1, 1, 0],
    "u": [1, 0, 1, 0, 0, 1],
    "v": [1, 1, 1, 0, 0, 1],
    "w": [0, 1, 0, 1, 1, 1],
    "x": [1, 0, 1, 1, 0, 1],
    "y": [1, 0, 1, 1, 1, 1],
    "z": [1, 0, 1, 0, 1, 1],
}

words = {
    "but": alphabets["b"],
    "can": alphabets["c"],
    "do": alphabets["d"],
    "every": alphabets["e"],
    "from": alphabets["f"],
    "go": alphabets["g"],
    "have": alphabets["h"],
    "just": alphabets["j"],
    "knowledge": alphabets["k"],
    "like": alphabets["l"],
    "more": alphabets["m"],
    "not": alphabets["n"],
    "people": alphabets["p"],
    "quite": alphabets["q"],
    "rather": alphabets["r"],
    "so": alphabets["s"],
    "that": alphabets["t"],
    "us": alphabets["u"],
    "very": alphabets["v"],
    "will": alphabets["w"],
    "it": alphabets["x"],
    "you": alphabets["y"],
    "as": alphabets["z"],
    "and": [1, 1, 1, 1, 0, 1],
    "of": [1, 1, 1, 0, 1, 1],
    "the": [0, 1, 1, 1, 0, 1],
    "with": [0, 1, 1, 1, 1, 1],
    "child": [1, 0, 0, 0, 0, 0],
    "shall": [1, 0, 0, 1, 0, 1],
    "this": [1, 0, 0, 1, 1, 1],
    "which": [1, 0, 0, 0, 1, 1],
    "out": [1, 1, 0, 0, 1, 1],
    "for": [1, 1, 1, 1, 1, 1],
    "was": [0, 0, 1, 0, 1, 1],
    "enough": [0, 1, 0, 0, 0, 1],
    "still": [0, 0, 1, 1, 0, 0],
    "his": [0, 1, 1, 0, 0, 1],
    "were": [0, 1, 1, 0, 1, 1],
    "by": [0, 0, 1, 0, 1, 1],
    "to": [0, 1, 1, 0, 1, 0],
    "be": [0, 1, 1, 0, 0, 0],
}

sounds = {
    "with": [0, 1, 1, 1, 1, 1],
    "con": words["can"],
    "dis": [0, 1, 0, 0, 1, 1],
    "ing": [0, 0, 1, 1, 0, 1],
    "the": [0, 1, 1, 1, 0, 1],
    "ble": [0, 0, 1, 1, 1, 1],
    "for": [1, 1, 1, 1, 1, 1],
    "and": [1, 1, 1, 1, 0, 1],
    "com": [0, 0, 1, 0, 0, 1],
    "ch": words["child"],
    "gh": [1, 1, 0, 0, 0, 1],
    "of": [1, 1, 1, 0, 1, 1],
    "ff": [0, 1, 1, 0, 1, 0],
    "gg": [0, 1, 1, 0, 1, 1],
    "sh": words["shall"],
    "th": words["this"],
    "wh": words["which"],
    "ed": [1, 1, 0, 1, 0, 1],
    "er": [1, 1, 0, 1, 1, 1],
    "ou": words["out"],
    "ow": [0, 1, 0, 1, 0, 1],
    "bb": [0, 1, 1, 0, 0, 0],
    "cc": words["can"],
    "dd": [0, 1, 0, 0, 1, 1],
    "en": [0, 1, 0, 0, 0, 1],
    "gg": words["were"],
    "in": [0, 0, 1, 0, 1, 0],
    "st": [0, 0, 1, 1, 0, 0],
    "ar": [0, 0, 1, 1, 1, 0],
    "be": [0, 1, 1, 0, 0, 0],
    "ea": [0, 1, 0, 0, 0, 0],
    "to": [0, 1, 1, 0, 1, 0],
    "by": [0, 0, 1, 0, 1, 1],
}

numbers = {
    "1": alphabets["a"],
    "2": alphabets["b"],
    "3": alphabets["c"],
    "4": alphabets["d"],
    "5": alphabets["e"],
    "6": alphabets["f"],
    "7": alphabets["g"],
    "8": alphabets["h"],
    "9": alphabets["i"],
    "0": alphabets["j"],
}

punctuation = {
    ".": [0, 1, 0, 0, 1, 1],
    ",": [0, 1, 0, 0, 0, 0],
    ";": [0, 1, 1, 0, 0, 0],
    ":": [0, 1, 0, 0, 1, 0],
    "'": [0, 0, 1, 0, 0, 0],
    "?": [0, 1, 1, 0, 0, 1],
    "!": [0, 1, 1, 0, 1, 0],
    "(": [0, 1, 1, 0, 1, 1],
    ")": [0, 1, 1, 0, 1, 1],
    "“": [0, 1, 1, 0, 0, 1],
    "”": [0, 0, 1, 0, 1, 1],
}


class Character:
    def __init__(self, character, dots):
        self.character = character
        self.dots = dots

    def __str__(self):
        caption = []
        arr = []

        for i in range(len(self.dots)):
            arr.append("⚪ " if self.dots[i] else "⚫ ")

            if (i + 1) % 3 == 0:
                caption.append(arr)
                arr = []

        out = ""

        for i in range(len(caption[0])):
            for arr in caption:
                out += arr[i]

            out += "\n"

        return out

    def __list__(self):
        return self.dots


class Word:
    def __init__(self, word):
        self.word = word
        self.characters = []

        self.convert()

    def convert(self):
        if self.word.lower() in list(words):
            if self.word[0].isupper():
                self.characters.append(Character("Capital", [0, 0, 0, 0, 0, 1]))

            self.characters.append(
                Character(self.word.lower(), words[self.word.lower()])
            )
            return

        characters = self._sound_check()

        character_follows = True
        number_follows = False
        caps = False

        for i in range(len(characters)):
            character = characters[i]

            if character.lower() in list(alphabets):
                if not character_follows:
                    if character.isupper():
                        self.characters.append(Character("Capital", [0, 0, 0, 0, 0, 1]))

                        if self.word.isupper():
                            self.characters.append(
                                Character("Capital", [0, 0, 0, 0, 0, 1])
                            )
                            caps = True

                    else:
                        self.characters.append(
                            Character("Character Follows", [0, 0, 0, 0, 1, 1])
                        )
                        caps = False

                    character_follows = True
                    number_follows = False

                else:
                    if character.isupper() and not caps:
                        self.characters.append(Character("Capital", [0, 0, 0, 0, 0, 1]))

                        if len(self.word) - 1 > i:
                            if self.word[i + 1].isupper():
                                self.characters.append(
                                    Character("Capital", [0, 0, 0, 0, 0, 1])
                                )
                                caps = True

                            else:
                                caps = False

                self.characters.append(
                    Character(character.lower(), alphabets[character.lower()])
                )

            elif character in list(numbers):
                if not number_follows:
                    self.characters.append(
                        Character("Number Follows", [0, 0, 1, 1, 1, 1])
                    )
                    number_follows = True
                    character_follows = False
                    caps = False

                self.characters.append(Character(character, numbers[character]))

            elif character in list(punctuation):
                self.characters.append(Character(character, punctuation[character]))
                caps = False

            elif character.lower() in list(sounds):
                if not character_follows:
                    if character.isupper():
                        if not caps:
                            self.characters.append(
                                Character("Capital", [0, 0, 0, 0, 0, 1])
                            )
                            self.characters.append(
                                Character("Capital", [0, 0, 0, 0, 0, 1])
                            )
                            caps = True

                    else:
                        self.characters.append(
                            Character("Character Follows", [0, 0, 0, 0, 1, 1])
                        )
                        caps = False

                    character_follows = True
                    number_follows = False

                else:
                    if character.isupper():
                        if not caps:
                            self.characters.append([0, 0, 0, 0, 0, 1])
                            self.characters.append([0, 0, 0, 0, 0, 1])
                            caps = True

                    else:
                        caps = False

                self.characters.append(
                    Character(character.lower(), sounds[character.lower()])
                )

            else:
                print(f"{self.word} doesn't have any match!")

    def _sound_check(self):
        characters = list(self.word)

        for sound in list(sounds):
            for i in range(len(characters) - len(sound) + 1):
                joined = "".join(characters[i : i + len(sound)])

                if joined.lower() == sound:
                    if (
                        (i == 0 and sound in ["ble", "ing"])
                        or (i != 0 and sound in ["be", "con", "dis", "com"])
                        or (
                            (i == 0 and i == len(characters) - 1)
                            and sound in ["bb", "cc", "dd", "ff", "gg", "ea"]
                        )
                    ):
                        continue

                    if joined.islower():
                        characters[i] = sound

                    elif joined.isupper():
                        characters[i] = sound.upper()

                    else:
                        continue

                    del characters[i + 1 : i + len(sound)]

        return characters

    def __str__(self):
        caption = ""

        for cell in self.characters:
            caption += str(cell)
            caption += cell.character
            caption += "\n\n"

        return caption

    def translate(self):
        return [
            [cell.dots for cell in self.characters],
            [cell.character for cell in self.characters],
        ]


class Braille:
    def __init__(self, sentence):
        self.sentence = sentence
        self.words = [Word(word) for word in sentence.split()]

    def translate(self):
        out = []
        count = 0

        for i in range(len(self.words)):
            if count > 0:
                count -= 1
                continue

            word = self.words[i]
            w = word.translate()

            if word.word.lower() in ["a", "and", "for", "of", "the", "with"]:
                count = 1

                if len(self.words) > i + count:
                    next_word = self.words[i + count]

                else:
                    next_word = Word("None")

                while next_word.word.lower() in [
                    "a",
                    "and",
                    "for",
                    "of",
                    "the",
                    "with",
                ]:
                    count += 1

                    translaion = next_word.translate()
                    w[0].extend(translaion[0])
                    w[1].extend(translaion[1])

                    if len(self.words) > i + count:
                        next_word = self.words[i + count]

                    else:
                        break

                count -= 1

                if i + count != len(self.words) - 1:
                    w[0].append([0, 0, 0, 0, 0, 0])
                    w[1].append("Space")

            elif self.words.index(word) != len(
                self.words
            ) - 1 and word.word.lower() not in ["to", "into", "by"]:
                w[0].append([0, 0, 0, 0, 0, 0])
                w[1].append("Space")

            out.append(w)

        for word in out:
            translaions, captions = word

            for i in range(len(translaions)):
                yield (translaions[i], captions[i])
