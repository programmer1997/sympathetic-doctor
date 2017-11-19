
% SYMPATHETIC DOCTOR
/*
----------main rule-----------------------------
start the program
*/

main:-initialize(),
      readPain(),
      readMood(),
      readFever(),
      readBowel(),
      readMiscellaneous(),
      diagnose().


% function to test yes or no
test(X):-
   X=='yes'.

initialize():- retractall(pain(_)),
               retractall(mood(_)),
               retractall(fever(_)),
               retractall(bowel(_)),
               retractall(miscellaneous(_)).


list_empty([]):-true().
list_empty([_|_]):-false().


% Symptom lists
pain_library([unbearable,strong,mild,manageable,no]).
mood_library([stressed,angry,weepy,depressed,calm]).
fever_library([very_high,high,mild,low,no]).
bowel_movements_library([hard,loose,tarry,bloody,normal]).
miscellaneous_library([itchy,giddy,hallucinating,twitches,palpitations,no_special_symptoms]).

% Record the symptoms of the patient by asserting the appropriate facts
pain().
mood().
fever().
bowel().
miscellaneous().



% Diseases rules
cancer():-pain(strong),mood(depressed),fever(mild),bowel(bloody),
          miscellaneous(giddy).
amoebiasis():-pain(unbearable),mood(weepy),fever(high),bowel(loose),
              miscellaneous(itchy).
rabies():-pain(strong),mood(angry),fever(high),bowel(normal),
          miscellaneous(hallucinating).
heart_trouble():-pain(unbearable),mood(stressed),fever(no),bowel(normal),
                 miscellaneous(palpitations).
dehydration():-pain(no),mood(calm),fever(no),bowel(hard),
               miscellaneous(giddy).


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
it splits the list into [H|L] i.e head and Tail
if the user says yes to head symptom, then true,
or else it calls the same predicate recursively passing the tail as parameter

*/
readPain(List):-
                  [H|T]=List,
                  format("Do you experience ~w pain",[H]),
                  read(X),
                  ((test(X);list_empty(T))->assert(pain(H));
                  readPain(T)
                  ).


readMood(List):-
                  [H|T]=List,
                  format("Do you feel ~w",[H]),
                  read(X),
                  ((test(X);list_empty(T))->assert(mood(H));
                  readMood(T)
                  ).


readFever(List):-
                  [H|T]=List,
                  format("Do you have ~w fever",[H]),
                  read(X),
                  ((test(X);list_empty(T))->assert(fever(H));
                  readFever(T)
                  ).


readBowel(List):-
                  [H|T]=List,
                  format("Do you experience ~w stools",[H]),
                  read(X),
                  ((test(X);list_empty(T))->assert(bowel(H));
                  readBowel(T)
                  ).

readMiscellaneous(List):-
                  [H|T]=List,
                  format("Do you experience ~w ",[H]),
                  read(X),
                  ((test(X);list_empty(T))->assert(miscellaneous(H));
                  readMiscellaneous(T)
                  ).
