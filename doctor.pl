
start:-readPain(),readMood(),diagnose().







% Symptom lists
pain([less,mild,strong]).
mood([angry,depressed,sad]).

% Diseases lists
cancer([less,angry]).
diabetes([mild,sad]).

diagnose():-nl,hasCancer()->write("has cancer");hasDiabetes()->write("You have diabetes");write("you have nothing").

hasCancer():-painlevel(X),moodlevel(Y),cancer(X),cancer(Y).
hasDiabetes():-painlevel(X),moodlevel(Y),diabetes(X),diabetes(Y).



painlevel().
moodlevel().




readPain() :-

    write('Do you experience pain?'),nl,read(X),
    test(X)->readPainLevel([less,mild,strong]);write("ok").

test(X):-
   X=='yes'.


readMood() :-
    write('Do you experience mood swings?'),nl,read(Y),
    test(Y)->readMoodLevel([angry,depressed,sad]);write("ok").



readPainLevel(List):-nth0(0,List,Elem),
                     [_|T]=List,
                     write("Is pain level  "),
                     write(Elem),
                     nl,
                     read(X),
                     (test(X)->assert(painlevel(Elem));
                     readPainLevel(T)
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

/*
pain([less,mild,strong]).
mood([angry,depressed,sad]).

pain_category=1.
mood_category=1.

hasDisease(X):-cancer(X);diabetes(X).

cancer(_):-
  pain_category==3,
   mood_category==2.

diabetes(_):-pain_category==1,
mood_category==1.
*/
