import loader
from program_strategy import AddNewIngredient, ListIngredeints, ListIngredeintsByName, TerminateProgram

if __name__ == '__main__':
    loader.load_initial_data()
    strategy_map = {
        "1": AddNewIngredient(),
        "2": ListIngredeints(),
        "3": ListIngredeintsByName(),
        "0": TerminateProgram()
    }
    while True:
        print("1 - Dodaj składnik", "2 - Pokaż wszytskie", "3 - Szukaj po nazwie", "0 - Zakończ",
              "Wybierz co chcesz zrobić", sep="\n")
        decision = input("> ")

        if decision not in strategy_map:
            print("Proszę wybrać poprwną wartość")
        else:
            strategy_map[decision].execute()
