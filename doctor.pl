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
predicates to read pain, mood... levels recursively.
It splits the parameter list into head and tail, thus checking for  the head and passing the tail if the user says no
*/
readPain(List):-  nth0(0,List,Elem),
                  [_|T]=List,
                  format("Do you experience ~w pain",[Elem]),
                  read(X),
                  (test(X)->assert(pain(Elem));
                  readPain(T)
                  ).


readMood(List):-  nth0(0,List,Elem),
                  [_|T]=List,
                  format("Do you feel ~w",[Elem]),
                  read(X),
                  (test(X)->assert(mood(Elem));
                  readMood(T)
                  ).


readFever(List):-  nth0(0,List,Elem),
                  [_|T]=List,
                  format("Do you have ~w fever",[Elem]),
                  read(X),
                  (test(X)->assert(fever(Elem));
                  readFever(T)
                  ).


readBowel(List):-  nth0(0,List,Elem),
                  [_|T]=List,
                  format("Do you experience ~w stools",[Elem]),
                  read(X),
                  (test(X)->assert(bowel(Elem));
                  readBowel(T)
                  ).

readMiscellaneous(List):-  nth0(0,List,Elem),
                  [_|T]=List,
                  format("Do you experience ~w ",[Elem]),
                  read(X),
                  (test(X)->assert(miscellaneous(Elem));
                  readMiscellaneous(T)
                  ).

/*


readPain() :-

    write('Do you experience pain?'),nl,read(X),
    test(X)->(pain_library(Y),readPainLevel(Y));write("ok").




readMood() :-
    write('Do you experience mood swings?'),nl,read(Y),
    test(Y)->readMoodLevel([angry,depressed,sad]);write("ok").



readPainLevel(List):-nth0(0,List,Elem),
                     [_|T]=List,
                     format("Do you experience ~w pain",[Elem]),
                     read(X),
                     (test(X)->assert(pain(Elem));
                     readPain(T)
                     ).

readMoodLevel(List):-nth0(0,List,Elem),
                     [_|T]=List,
                     write("Is mood type "),
                     write(Elem),
                     nl,
                     read(X),
                     (test(X)->assert(moodlevel(Elem));
                     readMoodLevel(T)
                     ).
*/
