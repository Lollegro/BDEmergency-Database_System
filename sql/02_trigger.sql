
DROP FUNCTION IF EXISTS AtLeastOneOnDanneggiamento() CASCADE;
DROP FUNCTION IF EXISTS Storicizzazione() CASCADE;
DROP FUNCTION IF EXISTS Calcolo_e_Aggiornamento_Reputazione() CASCADE;
DROP FUNCTION IF EXISTS Check_Creazione_o_Utilizzo_Tag() CASCADE;
DROP FUNCTION IF EXISTS AtLeastOneOnScrittura() CASCADE;
DROP FUNCTION IF EXISTS AtLeastOneOnContenimento() CASCADE;
DROP FUNCTION IF EXISTS AtLeastOneOnEtichetta() CASCADE;
DROP FUNCTION IF EXISTS AtLeastOneOnRedazione() CASCADE;
DROP FUNCTION IF EXISTS AtLeastOneOnDescrizione() CASCADE;
DROP FUNCTION IF EXISTS Check_Tipologia() CASCADE;
DROP FUNCTION IF EXISTS Check_Codice_Numerico() CASCADE;


--TRIGGER SU DANNEGGIAMENTO

CREATE OR REPLACE FUNCTION AtLeastOneOnDanneggiamento() returns trigger as $$
BEGIN
	if (exists (select Latitudine,Longitudine from ZonaColpita
		where Latitudine not in (select LatitudineZonaColpita from Danneggiamento where Longitudine = LongitudineZonaColpita))) then
		RAISE EXCEPTION 'Zona Colpita non associata a nessuna emergenza.';
	end if;
	if (exists (select Tipo,Nome from Emergenza
		where Tipo not in (select TipoEmergenza from Danneggiamento where Nome = NomeEmergenza))) then
		RAISE EXCEPTION 'Emergenza non associata a nessuna zona colpita.';
	end if;
return NEW;
END $$ LANGUAGE plpgsql;

create trigger AtLeastOneOnDanneggiamento1
after insert on ZonaColpita
for each row execute procedure AtLeastOneOnDanneggiamento();

create trigger AtLeastOneOnDanneggiamento2
after insert on Emergenza
for each row execute procedure AtLeastOneOnDanneggiamento();

create trigger AtLeastOneOnDanneggiamento3
after delete on Danneggiamento
for each row execute procedure AtLeastOneOnDanneggiamento();

--TRIGGER STORICIZZAZIONE

CREATE OR REPLACE FUNCTION Storicizzazione() returns trigger as $$
BEGIN
	if (old.Catalogazione = 'Emergenza Corrente') then
		update Emergenza set DataFine = current_date, Catalogazione = 'Emergenza Passata'
		where Tipo = old.Tipo and Nome = old.Nome;
		return null;
	else
		return old;
	end if;
END $$ language plpgsql;

create trigger ArchiviaEmergenze
before delete on Emergenza
for each row
execute procedure Storicizzazione();

--TRIGGER CALCOLO/AGGIORNAMENTO REPUTAZIONE UTENTE 

CREATE OR REPLACE FUNCTION Calcolo_e_Aggiornamento_Reputazione() returns trigger as $$
BEGIN
	if (old.ID is NULL) then
		update Utente set reputazione = reputazione + new.CounterMiPiace - new.CounterNonMiPiace
		where Username = new.UsernameUtente;
	elseif (old.CounterMiPiace <> new.CounterMiPiace and old.CounterNonMiPiace <> new.CounterNonMiPiace) then
		update Utente set reputazione = reputazione + new.CounterMiPiace - old.CounterMiPIace - new.CounterNonMiPiace + old.CounterNonMiPIace
		where Username = new.UsernameUtente;
	elseif (old.CounterMiPiace <> new.CounterMiPiace) then
		update Utente set reputazione = reputazione + new.CounterMiPiace - old.CounterMiPIace
		where Username = new.UsernameUtente;
	else
		update Utente set reputazione = reputazione - new.CounterNonMiPiace + old.CounterNonMiPIace
		where Username = new.UsernameUtente;
	end if;
return new;
END $$ language plpgsql;

create trigger Calcolo_Reputazione_su_inserimento
after insert on Commento
for each row
execute procedure Calcolo_e_Aggiornamento_Reputazione();

create trigger Calcolo_Reputazione_su_aggiornamento
after update of CounterMiPiace,CounterNonMiPiace on Commento
for each row
when (old.CounterMiPiace <> new.CounterMiPiace or old.CounterNonMiPiace <> new.CounterNonMiPiace)
execute procedure Calcolo_e_Aggiornamento_Reputazione();

--TRIGGER CHECK_CREAZIONE_O_UTILIZZO_TAG

CREATE OR REPLACE FUNCTION Check_Creazione_o_Utilizzo_Tag() returns trigger as $$
BEGIN
	if (not exists (select Username, Reputazione from Utente u 
		where u.Username = new.UsernameUtente and u.Reputazione > 0)) then
		RAISE EXCEPTION 'Utente non ha la reputazione necessaria per creare un tag o usarlo per etichettare un documento';
	end if;
return new;
END $$ language plpgsql;

create trigger Check_Creazione_Tag
after insert on Tag
for each row
execute procedure Check_Creazione_o_Utilizzo_Tag();

create trigger Check_Utilizzo_Tag
after insert on Etichetta
for each row
execute procedure Check_Creazione_o_Utilizzo_Tag();

create trigger Check_Creazione_Tag2
after update on Tag
for each row
execute procedure Check_Creazione_o_Utilizzo_Tag();

create trigger Check_Utilizzo_Tag2
after update on Etichetta
for each row
execute procedure Check_Creazione_o_Utilizzo_Tag();

-- TRIGGER SU SCRITTURA

CREATE OR REPLACE FUNCTION AtLeastOneOnScrittura() returns trigger as $$
BEGIN
	if (exists (select LinkSito from Documento
		where LinkSito not in (select LinkSitoDocumento from Scrittura))) then
		RAISE EXCEPTION 'Documento non associato a nessun autore.';
	end if;
	if (exists (select NumeroCartaIdentita from Autore
		where NumeroCartaIdentita not in (select NumeroCartaIdentitaAutore from Scrittura))) then
		RAISE EXCEPTION 'Autore non associato a nessun documento.';
	end if;
return NEW;
END $$ LANGUAGE plpgsql;

create trigger AtLeastOneOnScrittura1
after insert on Documento
for each row execute procedure AtLeastOneOnScrittura();

create trigger AtLeastOneOnScrittura2
after insert on Autore
for each row execute procedure AtLeastOneOnScrittura();

create trigger AtLeastOneOnScrittura3
after delete on Scrittura
for each row execute procedure AtLeastOneOnScrittura();

--TRIGGER SU CONTENIMENTO

CREATE OR REPLACE FUNCTION AtLeastOneOnContenimento() returns trigger as $$
BEGIN
	if (exists (select Parola from ParolaChiave
		where Parola not in (select ParolaChiave from Contenimento))) then
		RAISE EXCEPTION 'Parola chiave non associata a nessun documento';
	end if;
return NEW;
END $$ LANGUAGE plpgsql;

create trigger AtLeastOneOnContenimento
after insert on ParolaChiave
for each row execute procedure AtLeastOneOnContenimento();

--TRIGGER SU ETICHETTA

CREATE OR REPLACE FUNCTION AtLeastOneOnEtichetta() returns trigger as $$
BEGIN
	if (exists (select Nome from Tag
		where Nome not in (select NomeTag from Etichetta))) then
		RAISE EXCEPTION 'Tag non associato a nessun documento tramite etichetta.';
	end if;
return NEW;
END $$ LANGUAGE plpgsql;

create trigger AtLeastOneOnEtichetta
after insert on Tag
for each row execute procedure AtLeastOneOnEtichetta();

--TRIGGER SU REDAZIONE

CREATE OR REPLACE FUNCTION AtLeastOneOnRedazione() returns trigger as $$
BEGIN
	if (exists (select Nome,Ambito from EnteDiPubblicazione
		where Nome not in (select NomeEnte from Documento where Ambito = AmbitoEnte))) then
		RAISE EXCEPTION 'Ente di pubblicazione non associato a nessun documento.';
	end if;
return NEW;
END $$ LANGUAGE plpgsql;

create trigger AtLeastOneOnRedazione
after insert on EnteDiPubblicazione
for each row execute procedure AtLeastOneOnRedazione();

--TRIGGER SU DESCRIZIONE

CREATE OR REPLACE FUNCTION AtLeastOneOnDescrizione() returns trigger as $$
BEGIN
	if (exists (select Tipo,Nome from Emergenza
		where Tipo not in (select TipoEmergenza from Documento where Nome = NomeEmergenza))) then
		RAISE EXCEPTION 'Emergenza non è associata a nessun Documento';
	end if;
return NEW;
END $$ LANGUAGE plpgsql;

create trigger AtLeastOneOnDescrizione
after insert on Emergenza
for each row execute procedure AtLeastOneOnDescrizione();

--TRIGGER CONTROLLO TIPO DOCUMENTO

CREATE OR REPLACE FUNCTION Check_Tipologia() returns trigger as $$
BEGIN
	if(((not new.Tipologia = 'Articolo Giornalistico') and (not new.Tipologia = 'Pubblicazione Scientifica') and (not new.Tipologia = 'Decreto')) or new.Tipologia is NULL) then
		new.Tipologia = 'Miscellanea';
	end if;
return new;
END $$ language plpgsql;

create trigger Check_Tipologia
before insert on Documento
for each row
execute procedure Check_Tipologia();

--TRIGGER CHECK_CODICE_NUMERICO

CREATE OR REPLACE FUNCTION Check_Codice_Numerico() returns trigger as $$
BEGIN
	if (exists (select * from Documento
			where LinkSito <> new.LinkSito and Tipologia = new.Tipologia and CodiceNumerico = new.CodiceNumerico)) then
			RAISE EXCEPTION 'Codice numerico già presente nel database per la stessa tipologia.';
	end if;
return new;
END $$ language plpgsql;

create trigger Check_Codice_Numerico
after insert on Documento
for each row
execute procedure Check_Codice_Numerico();


