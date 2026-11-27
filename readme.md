# DSP – FIR szűrőtervezés ablakolással

A Pannon Egyetem mérnökinformatikus BSc képzésének Digitális jelfeldolgozás tantárgyához készült MATLAB-projektfeladat.

## A projekt célja

Aluláteresztő és felüláteresztő FIR szűrők tervezése téglalap- és Hamming-ablak alkalmazásával, a szűrők frekvenciaválaszának kiszámítása, valamint működésük bemutatása egy tesztjel szűrésével.

## Fájlok

| Fájl | Feladat |
|---|---|
| `fir_ablak.m` | FIR szűrők tervezése ablakolással. |
| `freqvalasz.m` | A szűrő komplex frekvenciaválaszának kiszámítása. |
| `teszt_fir.m` | Az elkészített függvények ellenőrzése öt tesztesettel. |
| `szures_demo.m` | A szűrés, a frekvenciaválasz és a kauzális szűrő késleltetésének bemutatása. |

## Futtatás

Az ellenőrző tesztek futtatása: `teszt_fir`

A szűrés és az ábrák megjelenítése: `szures_demo`

A projekt felhasználja a korábbi konvolúciós projektben elkészített `matkonv_idx` függvényt és annak függőségeit.

## Fejlesztői környezet

- MATLAB
- Git / GitHub