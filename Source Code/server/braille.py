from constant import alpha, nums, punct, sounds, words


class Cell:
    def __init__(self, letter, dots):
        self.letter = letter
        self.dots = dots

    def __str__(self):
        rep = []
        arr = []

        for i in range(len(self.dots)):
            arr.append("⚪ " if self.dots[i] else "⚫ ")

            if (i + 1) % 3 == 0:
                rep.append(arr)
                arr = []

        out = ""

        for i in range(len(rep[0])):
            for arr in rep:
                out += arr[i]

            out += "\n"

        return out

    def __list__(self):
        return self.dots


class Word:
    def __init__(self, word):
        self.word = word
        self.cells = []

        self.convert()

    def convert(self):
        if self.word.lower() in list(words):
            if self.word[0].isupper():
                self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))

            self.cells.append(Cell(self.word.lower(), words[self.word.lower()]))
            return

        char_list = self._sound_check()

        char_follows = True
        num_follows = False
        caps = False

        for i in range(len(char_list)):
            char = char_list[i]

            if char.lower() in list(alpha):
                if not char_follows:
                    if char.isupper():
                        self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))

                        if len(self.word) - 1 > i:
                            if self.word[i + 1].isupper():
                                self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))
                                caps = True

                    else:
                        self.cells.append(Cell("Letter Follows", [0, 0, 0, 0, 1, 1]))
                        caps = False

                    char_follows = True
                    num_follows = False

                else:
                    if char.isupper() and not caps:
                        self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))

                        if len(self.word) - 1 > i:
                            if self.word[i + 1].isupper():
                                self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))
                                caps = True

                            else:
                                caps = False

                self.cells.append(Cell(char.lower(), alpha[char.lower()]))

            elif char in list(nums):
                if not num_follows:
                    self.cells.append(Cell("Number Follows", [0, 0, 1, 1, 1, 1]))
                    num_follows = True
                    char_follows = False
                    caps = False

                self.cells.append(Cell(char, nums[char]))

            elif char in list(punct):
                self.cells.append(Cell(char, punct[char]))
                caps = False

            elif char.lower() in list(sounds):
                if not char_follows:
                    if char.isupper():
                        if not caps:
                            self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))
                            self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))
                            caps = True

                    else:
                        self.cells.append(Cell("Letter Follows", [0, 0, 0, 0, 1, 1]))
                        caps = False

                    char_follows = True
                    num_follows = False

                else:
                    if char.isupper():
                        if not caps:
                            self.cells.append([0, 0, 0, 0, 0, 1])
                            self.cells.append([0, 0, 0, 0, 0, 1])
                            caps = True

                    else:
                        caps = False

                self.cells.append(Cell(char.lower(), sounds[char.lower()]))

            else:
                print(f"{self.word} doesn't have any match!")

    def _sound_check(self):
        char_list = list(self.word)

        for sound in list(sounds):
            for i in range(len(char_list) - len(sound) + 1):
                joined = "".join(char_list[i : i + len(sound)])

                if joined.lower() == sound:
                    if (
                        (i == 0 and sound in ["ble", "ing"])
                        or (i != 0 and sound in ["be", "con", "dis", "com"])
                        or (
                            (i == 0 and i == len(char_list) - 1)
                            and sound in ["bb", "cc", "dd", "ff", "gg", "ea"]
                        )
                    ):
                        print("Continuing...", sound, i)
                        continue

                    if joined.islower():
                        char_list[i] = sound

                    elif joined.isupper():
                        char_list[i] = sound.upper()

                    else:
                        continue

                    del char_list[i + 1 : i + len(sound)]

        return char_list

    def __str__(self):
        rep = ""

        for cell in self.cells:
            rep += str(cell)
            rep += cell.letter
            rep += "\n\n"

        return rep

    def toSignal(self):
        return [
            [cell.dots for cell in self.cells],
            [cell.letter for cell in self.cells],
        ]

    def toList(self):
        return self.cells


class Sentence:
    def __init__(self, sentence):
        self.sentence = sentence
        self.words = [Word(word) for word in sentence.split()]

    def display(self):
        out = []
        count = 0

        for i in range(len(self.words)):
            if count > 0:
                count -= 1
                continue

            word = self.words[i]

            out += str(word)

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
                    out += str(next_word)

                    if len(self.words) > i + count:
                        next_word = self.words[i + count]

                    else:
                        break

                count -= 1

                if i + count != len(self.words) - 1:
                    out += str(Cell("Space", [0, 0, 0, 0, 0, 0]))
                    out += "Space\n\n"

            elif self.words.index(word) != len(
                self.words
            ) - 1 and word.word.lower() not in ["to", "into", "by"]:
                out += str(Cell("Space", [0, 0, 0, 0, 0, 0]))
                out += "Space\n\n"

        return out

    def toSignal(self):
        out = []
        count = 0

        for i in range(len(self.words)):
            if count > 0:
                count -= 1
                continue

            word = self.words[i]
            w = word.toSignal()

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

                    signal = next_word.toSignal()
                    w[0].extend(signal[0])
                    w[1].extend(signal[1])

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
            signals, letters = word

            for i in range(len(signals)):
                yield (signals[i], letters[i])

    def toList(self):
        out = []
        count = 0

        for i in range(len(self.words)):
            if count > 0:
                count -= 1
                continue

            word = self.words[i]
            w = word.toList()

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
                    w.extend(next_word.toList())

                    if len(self.words) > i + count:
                        next_word = self.words[i + count]

                    else:
                        break

                count -= 1

                if i + count != len(self.words) - 1:
                    w.append(Cell("Space", [0, 0, 0, 0, 0, 0]))

            elif self.words.index(word) != len(
                self.words
            ) - 1 and word.word.lower() not in ["to", "into", "by"]:
                w.append(Cell("Space", [0, 0, 0, 0, 0, 0]))

            out.append(w)

        for word in out:
            for cell in word:
                yield cell
