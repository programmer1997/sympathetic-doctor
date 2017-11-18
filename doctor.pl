/*
----------main rule-----------------------------
readPain() read the amount of pain,
readMood() reads mood  etc.
diagnose() diagnoses the disease based on the symptoms
program ends
*/
main:-readPain(),readMood(),readFever(),readBowel(),readMiscellaneous(),diagnose().


% function to test yes or no
test(X):-
   X=='yes'.


% Symptom lists
pain_library([unbearable,strong,mild,manageable,no]).
mood_library([calm,angry,weepy,depressed,stressed]).
fever_library([very_high,high,mild,low,no]).
bowel_movements_library([hard,loose,tarry,bloody,normal]).
miscellaneous_library([itchy,giddy,hallucinating,twitches,palpitations]).

% Record the symptoms of the patient by asserting the appropriate facts
pain().
mood().
fever().
bowel().
miscellaneous().



% Diseases rules
cancer():-pain(strong),mood(depressed),fever(mild),bowel(bloody),miscellaneous(giddy).
amoebiasis():-pain(unbearable),mood(weepy),fever(high),bowel(loose),miscellaneous(itchy).
rabies():-pain(strong),mood(angry),fever(high),bowel(normal),miscellaneous(hallucinating).
heart_trouble():-pain(unbearable),mood(stressed),fever(no),bowel(normal),miscellaneous(palpitations).
dehydration():-pain(no),mood(calm),fever(no),bowel(hard),miscellaneous(giddy).


% checks meets conditions for which disease and prints the disease
diagnose():-nl,
            cancer()->write("You may have cancer. I recommend undergoing medical tests");
            amoebiasis()->write("You have amoebiasis. I will prescribe you the antibiotics");
            rabies()->write("You have rabies. We have to admit you to the hospital");
            heart_trouble()->write("You may have heart trouble. I recommend a stress test immediately");
            dehydration()->write("Nothing to worry. Drink a lot of water with electrolytes");
            write("We need further testing to ascertain the cause").


/*
predicates  readPain/0, readMood/0, etc  to pass the appropriate lists to readPain/1, readMood/1 etc.
*/
readPain():-pain_library(X),readPain(X).
readMood():-mood_library(X),readMood(X).
readFever():-fever_library(X),readFever(X).
readBowel():-bowel_movements_library(X),readBowel(X).
readMiscellaneous():-miscellaneous_library(X),readMiscellaneous(X).

/*
predicates to readPain/1, moodLevel/1... to read pain,mood  recursively.

*/
readPain(List):-
                  [H|T]=List,
                  format("Do you experience ~w pain",[H]),
                  read(X),
                  (test(X)->assert(pain(H));
                  readPain(T)
                  ).


readMood(List):-
                  [H|T]=List,
                  format("Do you feel ~w",[H]),
                  read(X),
                  (test(X)->assert(mood(H));
                  readMood(T)
                  ).


readFever(List):-
                  [H|T]=List,
                  format("Do you have ~w fever",[H]),
                  read(X),
                  (test(X)->assert(fever(H));
                  readFever(T)
                  ).


readBowel(List):-
                  [H|T]=List,
                  format("Do you experience ~w stools",[H]),
                  read(X),
                  (test(X)->assert(bowel(H));
                  readBowel(T)
                  ).

readMiscellaneous(List):-
                  [H|T]=List,
                  format("Do you experience ~w ",[H]),
                  read(X),
                  (test(X)->assert(miscellaneous(H));
                  readMiscellaneous(T)
                  ).
