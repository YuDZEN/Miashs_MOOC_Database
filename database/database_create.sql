-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-03-11 20:25:07.925

-- tables
-- Table: ASSIGNER
CREATE TABLE ASSIGNER (
    COURS_intitule_cours varchar(128)  NOT NULL,
    UTILISATEUR_id_utilisateur int  NOT NULL,
    CONSTRAINT ASSIGNER_pk PRIMARY KEY (COURS_intitule_cours,UTILISATEUR_id_utilisateur)
);

-- Table: ATTRIBUER
CREATE TABLE ATTRIBUER (
    ROLE_id_role int  NOT NULL,
    UTILISATEUR_id_utilisateur int  NOT NULL,
    CONSTRAINT ATTRIBUER_pk PRIMARY KEY (ROLE_id_role,UTILISATEUR_id_utilisateur)
);

-- Table: CORRIGER
CREATE TABLE CORRIGER (
    UTILISATEUR_id_utilisateur int  NOT NULL,
    TENTATIVE_EXAMEN_id_tentative int  NOT NULL,
    score_obtenu int  NOT NULL,
    CONSTRAINT CORRIGER_pk PRIMARY KEY (UTILISATEUR_id_utilisateur,TENTATIVE_EXAMEN_id_tentative)
);

-- Table: COURS
CREATE TABLE COURS (
    intitule_cours varchar(128)  NOT NULL,
    descriptions text  NOT NULL,
    prix decimal(10,2)  NOT NULL,
    pre_requis varchar(256)  NOT NULL,
    date_debut date  NULL,
    date_fin date  NULL,
    CONSTRAINT COURS_pk PRIMARY KEY (intitule_cours)
);

-- Table: CREER
CREATE TABLE CREER (
    COURS_intitule_cours varchar(128)  NOT NULL,
    UTILISATEUR_id_utilisateur int  NOT NULL,
    CONSTRAINT CREER_pk PRIMARY KEY (COURS_intitule_cours,UTILISATEUR_id_utilisateur)
);

-- Table: EVALUER
CREATE TABLE EVALUER (
    UTILISATEUR_id_utilisateur int  NOT NULL,
    NOTE_id_evaluation int  NOT NULL,
    CONSTRAINT EVALUER_pk PRIMARY KEY (NOTE_id_evaluation,UTILISATEUR_id_utilisateur)
);

-- Table: EXAMEN
CREATE TABLE EXAMEN (
    titre_examen varchar(255)  NOT NULL,
    contenu_examen text  NOT NULL,
    score_mini decimal(10,2)  NOT NULL,
    PARTIE_intitule_cours varchar(128)  NOT NULL,
    PARTIE_titre_partie varchar(128)  NOT NULL,
    CONSTRAINT EXAMEN_pk PRIMARY KEY (titre_examen)
);

-- Table: INSCRIRE
CREATE TABLE INSCRIRE (
    UTILISATEUR_id_utilisateur int  NOT NULL,
    COURS_intitule_cours varchar(128)  NOT NULL,
    montant decimal(10,2)  NOT NULL,
    date_payment timestamp  NOT NULL,
    CONSTRAINT INSCRIRE_pk PRIMARY KEY (UTILISATEUR_id_utilisateur,COURS_intitule_cours)
);

-- Table: NOTE
CREATE TABLE NOTE (
    id_evaluation int  NOT NULL,
    id_utilisateur int  NOT NULL,
    intitule_cours varchar(128)  NOT NULL,
    note smallint  NOT NULL,
    commentaire varchar(255)  NOT NULL,
    COURS_intitule_cours varchar(128)  NOT NULL,
    CONSTRAINT NOTE_pk PRIMARY KEY (id_evaluation)
);

-- Table: PARTIE
CREATE TABLE PARTIE (
    intitule_cours varchar(128)  NOT NULL,
    titre_partie varchar(128)  NOT NULL,
    contenu text  NOT NULL,
    chapitre smallint  NULL,
    COURS_intitule_cours varchar(128)  NOT NULL,
    CONSTRAINT PARTIE_pk PRIMARY KEY (intitule_cours,titre_partie)
);

-- Table: PROGRESSER
CREATE TABLE PROGRESSER (
    UTILISATEUR_id_utilisateur int  NOT NULL,
    PARTIE_intitule_cours varchar(128)  NOT NULL,
    PARTIE_titre_partie varchar(128)  NOT NULL,
    etat boolean  NOT NULL,
    date timestamp  NOT NULL,
    CONSTRAINT PROGRESSER_pk PRIMARY KEY (UTILISATEUR_id_utilisateur,PARTIE_intitule_cours,PARTIE_titre_partie)
);

-- Table: ROLE
CREATE TABLE ROLE (
    id_role int  NOT NULL,
    libelle varchar(128)  NOT NULL,
    CONSTRAINT ROLE_pk PRIMARY KEY (id_role)
);

-- Table: SESSION
CREATE TABLE SESSION (
    intitule_cours varchar(128)  NOT NULL,
    date_debut timestamp  NOT NULL,
    date_fin timestamp  NOT NULL,
    nombre_de_palce int  NULL,
    COURS_intitule_cours varchar(128)  NOT NULL,
    CONSTRAINT SESSION_pk PRIMARY KEY (intitule_cours,date_debut,date_fin)
);

-- Table: SESSION_UTILISATEUR
CREATE TABLE SESSION_UTILISATEUR (
    SESSION_intitule_cours varchar(128)  NOT NULL,
    SESSION_date_debut timestamp  NOT NULL,
    SESSION_date_fin timestamp  NOT NULL,
    UTILISATEUR_id_utilisateur int  NOT NULL,
    CONSTRAINT SESSION_UTILISATEUR_pk PRIMARY KEY (SESSION_intitule_cours,SESSION_date_debut,SESSION_date_fin,UTILISATEUR_id_utilisateur)
);

-- Table: TENTATIVE_EXAMEN
CREATE TABLE TENTATIVE_EXAMEN (
    id_tentative int  NOT NULL,
    titre_examen varchar(128)  NOT NULL,
    date date  NOT NULL,
    score_obtenu decimal(10,2)  NOT NULL,
    EXAMEN_titre_examen varchar(255)  NOT NULL,
    CONSTRAINT TENTATIVE_EXAMEN_pk PRIMARY KEY (id_tentative)
);

-- Table: Tenter
CREATE TABLE Tenter (
    UTILISATEUR_id_utilisateur int  NOT NULL,
    TENTATIVE_EXAMEN_id_tentative int  NOT NULL,
    CONSTRAINT Tenter_pk PRIMARY KEY (UTILISATEUR_id_utilisateur,TENTATIVE_EXAMEN_id_tentative)
);

-- Table: UTILISATEUR
CREATE TABLE UTILISATEUR (
    id_utilisateur int  NOT NULL,
    nom varchar(128)  NOT NULL,
    prenom varchar(128)  NOT NULL,
    email varchar(128)  NOT NULL,
    id_role int  NOT NULL,
    CONSTRAINT UTILISATEUR_pk PRIMARY KEY (id_utilisateur)
);

-- foreign keys
-- Reference: COURS_CREER (table: CREER)
ALTER TABLE CREER ADD CONSTRAINT COURS_CREER
    FOREIGN KEY (COURS_intitule_cours)
    REFERENCES COURS (intitule_cours)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: COURS_PAYER (table: INSCRIRE)
ALTER TABLE INSCRIRE ADD CONSTRAINT COURS_PAYER
    FOREIGN KEY (COURS_intitule_cours)
    REFERENCES COURS (intitule_cours)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: COURS_assigner (table: ASSIGNER)
ALTER TABLE ASSIGNER ADD CONSTRAINT COURS_assigner
    FOREIGN KEY (COURS_intitule_cours)
    REFERENCES COURS (intitule_cours)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: ETUDIANT_DETAIL_AVANCEMENT (table: PROGRESSER)
ALTER TABLE PROGRESSER ADD CONSTRAINT ETUDIANT_DETAIL_AVANCEMENT
    FOREIGN KEY (UTILISATEUR_id_utilisateur)
    REFERENCES UTILISATEUR (id_utilisateur)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: ETUDIANT_PAIEMENT (table: INSCRIRE)
ALTER TABLE INSCRIRE ADD CONSTRAINT ETUDIANT_PAIEMENT
    FOREIGN KEY (UTILISATEUR_id_utilisateur)
    REFERENCES UTILISATEUR (id_utilisateur)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: EXAMEN_PARTIE (table: EXAMEN)
ALTER TABLE EXAMEN ADD CONSTRAINT EXAMEN_PARTIE
    FOREIGN KEY (PARTIE_intitule_cours, PARTIE_titre_partie)
    REFERENCES PARTIE (intitule_cours, titre_partie)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: NOTE_COURS (table: NOTE)
ALTER TABLE NOTE ADD CONSTRAINT NOTE_COURS
    FOREIGN KEY (COURS_intitule_cours)
    REFERENCES COURS (intitule_cours)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: NOTE_EVALUER (table: EVALUER)
ALTER TABLE EVALUER ADD CONSTRAINT NOTE_EVALUER
    FOREIGN KEY (NOTE_id_evaluation)
    REFERENCES NOTE (id_evaluation)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: PARTIE_COURS (table: PARTIE)
ALTER TABLE PARTIE ADD CONSTRAINT PARTIE_COURS
    FOREIGN KEY (COURS_intitule_cours)
    REFERENCES COURS (intitule_cours)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: PARTIE_PROGRESSER (table: PROGRESSER)
ALTER TABLE PROGRESSER ADD CONSTRAINT PARTIE_PROGRESSER
    FOREIGN KEY (PARTIE_intitule_cours, PARTIE_titre_partie)
    REFERENCES PARTIE (intitule_cours, titre_partie)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: ROLE_ATTRIBUER (table: ATTRIBUER)
ALTER TABLE ATTRIBUER ADD CONSTRAINT ROLE_ATTRIBUER
    FOREIGN KEY (ROLE_id_role)
    REFERENCES ROLE (id_role)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: SESSION_COURS (table: SESSION)
ALTER TABLE SESSION ADD CONSTRAINT SESSION_COURS
    FOREIGN KEY (COURS_intitule_cours)
    REFERENCES COURS (intitule_cours)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: SESSION_UTILISATEUR_SESSION (table: SESSION_UTILISATEUR)
ALTER TABLE SESSION_UTILISATEUR ADD CONSTRAINT SESSION_UTILISATEUR_SESSION
    FOREIGN KEY (SESSION_intitule_cours, SESSION_date_debut, SESSION_date_fin)
    REFERENCES SESSION (intitule_cours, date_debut, date_fin)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: SESSION_UTILISATEUR_UTILISATEUR (table: SESSION_UTILISATEUR)
ALTER TABLE SESSION_UTILISATEUR ADD CONSTRAINT SESSION_UTILISATEUR_UTILISATEUR
    FOREIGN KEY (UTILISATEUR_id_utilisateur)
    REFERENCES UTILISATEUR (id_utilisateur)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: TENTATIVE_EXAMEN_CORRIGER (table: CORRIGER)
ALTER TABLE CORRIGER ADD CONSTRAINT TENTATIVE_EXAMEN_CORRIGER
    FOREIGN KEY (TENTATIVE_EXAMEN_id_tentative)
    REFERENCES TENTATIVE_EXAMEN (id_tentative)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: TENTATIVE_EXAMEN_EXAMEN (table: TENTATIVE_EXAMEN)
ALTER TABLE TENTATIVE_EXAMEN ADD CONSTRAINT TENTATIVE_EXAMEN_EXAMEN
    FOREIGN KEY (EXAMEN_titre_examen)
    REFERENCES EXAMEN (titre_examen)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: TENTATIVE_EXAMEN_Tenter (table: Tenter)
ALTER TABLE Tenter ADD CONSTRAINT TENTATIVE_EXAMEN_Tenter
    FOREIGN KEY (TENTATIVE_EXAMEN_id_tentative)
    REFERENCES TENTATIVE_EXAMEN (id_tentative)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: UTILISATEUR_ATTRIBUER (table: ATTRIBUER)
ALTER TABLE ATTRIBUER ADD CONSTRAINT UTILISATEUR_ATTRIBUER
    FOREIGN KEY (UTILISATEUR_id_utilisateur)
    REFERENCES UTILISATEUR (id_utilisateur)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: UTILISATEUR_CORRIGER (table: CORRIGER)
ALTER TABLE CORRIGER ADD CONSTRAINT UTILISATEUR_CORRIGER
    FOREIGN KEY (UTILISATEUR_id_utilisateur)
    REFERENCES UTILISATEUR (id_utilisateur)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: UTILISATEUR_CREER (table: CREER)
ALTER TABLE CREER ADD CONSTRAINT UTILISATEUR_CREER
    FOREIGN KEY (UTILISATEUR_id_utilisateur)
    REFERENCES UTILISATEUR (id_utilisateur)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: UTILISATEUR_EVALUER (table: EVALUER)
ALTER TABLE EVALUER ADD CONSTRAINT UTILISATEUR_EVALUER
    FOREIGN KEY (UTILISATEUR_id_utilisateur)
    REFERENCES UTILISATEUR (id_utilisateur)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: UTILISATEUR_Tenter (table: Tenter)
ALTER TABLE Tenter ADD CONSTRAINT UTILISATEUR_Tenter
    FOREIGN KEY (UTILISATEUR_id_utilisateur)
    REFERENCES UTILISATEUR (id_utilisateur)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: UTILISATEUR_assigner (table: ASSIGNER)
ALTER TABLE ASSIGNER ADD CONSTRAINT UTILISATEUR_assigner
    FOREIGN KEY (UTILISATEUR_id_utilisateur)
    REFERENCES UTILISATEUR (id_utilisateur)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- sequences
-- Sequence: NOTE_seq
CREATE SEQUENCE NOTE_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1
      NO CYCLE
;

-- Sequence: ROLE_seq
CREATE SEQUENCE ROLE_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1
      NO CYCLE
;

-- Sequence: TENTATIVE_EXAMEN_seq
CREATE SEQUENCE TENTATIVE_EXAMEN_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1
      NO CYCLE
;

-- Sequence: UTILISATEUR_seq
CREATE SEQUENCE UTILISATEUR_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1
      NO CYCLE
;

-- End of file.

