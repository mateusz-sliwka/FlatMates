# FlatMates - mieszkanie studenckie

Prosta aplikaca webowa wykonana w technologii JSP z użyciem Maven, Hibernate, Bootstrap oraz bazy danych MySQL.

**UWAGA!** W niektórych przypadkach, do pełnej zsynchronizowania bazy danych Oracle z aplikacją opartą o Hibernate wymagana jest zmiana limitów bazy. W tym celu należy wykonać poniższe zapytanie (z poziomu administratora bazy) i uruchomić serwer ponownie.
```
alter system set processes = 500 scope = spfile;
alter system set sessions = 400 scope = spfile;
```
## Plan rozwoju

* zaimplementowanie serwletów jako jedynej metody obsługi formularza, zwiększenie bezpieczeństwa (obecnie niskiego)
* stworzenie tożsamej aplikacji w Springu, zestawienie różnić JSP i Spring

