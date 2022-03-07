Q = [10 1 1 1];
R = 1;

Vektlegger travel ganske mye på feedback-controlleren fordi det er travel det er laget en optimal path for. Følger denne nogenlunde, men litt stasjonært avvik.
Vi tror dette skyldes at modellen ikke er helt korrekt, spesifikt at det kreves en pitch angle != 0 for å holde konstant travel-vinkel.
Dette gjør at pitch og travel kjemper mot hverandre. Å øke fra Q(1) fra 1 til 10 hadde noe effekt, men fjenet ikke det stasjonære avviket helt.