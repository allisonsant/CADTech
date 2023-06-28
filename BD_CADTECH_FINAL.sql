----------------------------__________CREATE_TABLES__________----------------------------

--TABLE_ALUNO--
DROP TABLE IF EXISTS aluno CASCADE;
CREATE TABLE aluno (
  ra_aluno            INT          PRIMARY KEY,
  nome_aluno          VARCHAR(70)  NOT NULL,
  cpf_aluno           CHAR(11)     NOT NULL,	
  data_nasc_aluno     DATE         NOT NULL,
  end_aluno           VARCHAR(70)  NOT NULL,
  fone_aluno          VARCHAR(12)  NOT NULL,
  gender_aluno        CHAR(1)      CHECK(gender_aluno IN ('M', 'F'))
);

--TABLE_PROFESSOR--
DROP TABLE IF EXISTS professor CASCADE;
CREATE TABLE professor (
  id_professor        SMALLINT     PRIMARY KEY,
  nome_professor      VARCHAR(70)  NOT NULL,
  cpf_professor       CHAR(11)     NOT NULL,
  data_nasc_professor DATE         NOT NULL,	
  end_professor       VARCHAR(70)  NOT NULL,
  fone_professor      VARCHAR(20)  NOT NULL,
  gender_professor    CHAR(1)      CHECK(gender_professor IN ('M', 'F'))
);

--TABLE_MATERIA--
DROP TABLE IF EXISTS materia CASCADE;
CREATE TABLE materia (
  id_materia          SMALLINT     PRIMARY KEY,
  nome_materia        VARCHAR(30)  NOT NULL
);

--TABLE_REPERTORIO_ALUNO--
DROP TABLE IF EXISTS repertorio_aluno CASCADE;
CREATE TABLE repertorio_aluno (
  id_report_aluno     SERIAL       PRIMARY KEY,
  ra_aluno            INT          NOT NULL,
  id_materia          SMALLINT     NOT NULL,
  faltas_aluno        INT          NOT NULL,
  situacao_aluno      VARCHAR(9)   CHECK(situacao_aluno in ('APROVADO', 'REPROVADO', 'CURSANDO')),
  FOREIGN KEY (ra_aluno) REFERENCES aluno(ra_aluno)
  	on DELETE cascade on update CASCADE,
  FOREIGN KEY (id_materia) REFERENCES materia(id_materia)
  	on DELETE cascade on update CASCADE		
);

--TABLE_TURMA--
DROP TABLE IF EXISTS turma CASCADE;
CREATE TABLE turma (
  id_turma            CHAR(2)     PRIMARY KEY,
  periodo_turma       CHAR(10)    CHECK(periodo_turma in ('MATUTINO', 'VESPERTINO', 'NOTURNO'))	
);

--TABLE_AULA--
DROP TABLE IF EXISTS aula CASCADE;
CREATE TABLE aula (
  id_aula             SERIAL       PRIMARY KEY,
  id_turma            CHAR(2)      NOT NULL,
  id_professor        INT          NOT NULL,
  id_materia          INT          NOT NULL,
  FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
  	on DELETE cascade on update CASCADE,
  FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
  	on DELETE cascade on update CASCADE,
  FOREIGN KEY (id_materia) REFERENCES materia(id_materia)
  	on DELETE cascade on update CASCADE	
);

--TABLE_TURMA_ALUNO--
DROP TABLE IF EXISTS turma_aluno CASCADE;
CREATE TABLE turma_aluno (
  id_turma_aluno      SMALLINT     PRIMARY KEY,
  id_turma            CHAR(2)      NOT NULL,
  ra_aluno            INT          NOT NULL,
  FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
  	on DELETE cascade on update CASCADE,
  FOREIGN KEY (ra_aluno) REFERENCES aluno(ra_aluno)
  	on DELETE cascade on update CASCADE	
);	

--TABLE_REPOSICAO_AULA--
DROP TABLE IF EXISTS reposicao_aula CASCADE;
CREATE TABLE reposicao_aula (
  id_reposicao_aula   SERIAL       PRIMARY KEY,
  id_aula             SERIAL       NOT NULL,
  reposicao_data      DATE         NOT NULL,
  reposicao_periodo   CHAR(10)     CHECK(reposicao_periodo in ('MATUTINO', 'VESPERTINO', 'NOTURNO')),
  FOREIGN KEY (id_aula) REFERENCES aula(id_aula)
  	on DELETE cascade on update CASCADE
);

----------------------------__________INSERT_TABLES__________----------------------------

--TABLE_ALUNO--
SELECT * FROM aluno;
INSERT INTO aluno (ra_aluno, nome_aluno, cpf_aluno, data_nasc_aluno, end_aluno, fone_aluno, gender_aluno) VALUES 
(100001, 'João da Silva',     '12345678901', '1994/05/02', 'Rua José Domingos, 55', '1194567890', 'M'),
(100002, 'Maria Oliveira',    '23456789012', '2001/02/09', 'Rua Barcelona, 46',     '1195678901', 'F'),
(100003, 'Pedro Santos',      '34567890123', '1999/02/05', 'Avenida Loyal, 789',    '1196789012', 'M'),
(100004, 'Ana Costa',         '45678901234', '1995/02/04', 'Rua Jejo, 012',         '1197890123', 'F'),
(100005, 'Lucas Souza',       '56789012345', '1991/02/05', 'Rua Tolstoi, 345',      '1198901234', 'M'),
(100006, 'Mariana Pereira',   '67890123456', '1997/02/05', 'Rua Final, 78',         '1199012345', 'F'),
(100007, 'Carlos Mendes',     '78901234567', '1994/02/01', 'Avenida Gemma, 901',    '1190123456', 'M'),
(100008, 'Juliana Rodrigues', '89012345678', '1992/02/05', 'Rua Holerte, 234',      '1191234567', 'F'),
(100009, 'Gustavo Almeida',   '90123456789', '1991/05/30', 'Rua Aorta, 567',        '1192345678', 'M'),
(100010, 'Laura Silva',       '01234567890', '1991/02/04', 'Rua Benza Do, 890',     '1193456789', 'F'),
(100011, 'Roberto Santos',    '12345678901', '1984/02/09', 'Rua Luvia Silva, 123',  '1194567890', 'M'),
(100012, 'Fernanda Oliveira', '23456789012', '1977/02/06', 'Rua Vergueiro, 456',    '1195678901', 'F'),
(100013, 'Ricardo Costa',     '34567890123', '1989/02/25', 'Rua Mateo Bei, 789',    '1196789012', 'M'),
(100014, 'Marcela Souza',     '45678901234', '2001/02/22', 'Rua Uva Fruta, 012',    '1197890123', 'F'),
(100015, 'Daniel Pereira',    '56789012345', '2005/02/04', 'Rua Vazo, 345',         '1198901234', 'M'),
(100016, 'Isabela Mendes',    '67890123456', '1997/02/01', 'Rua Pindamo, 678',      '1199012345', 'F'),
(100017, 'Eduardo Rodrigues', '78901234567', '1992/02/01', 'Rua Erasmos Co, 901',   '1190123456', 'M'),
(100018, 'Carolina Almeida',  '89012345678', '1997/02/01', 'Rua Legal, 24',         '1191234567', 'F'),
(100019, 'Henrique Silva',    '90123456789', '1998/02/09', 'Rua de Souza, 57',      '1192345678', 'M'),
(100020, 'Beatriz Oliveira',  '01234567890', '1998/02/02', 'Rua Transformers, 890', '1193456789', 'F'),
(100021, 'Renato Santos',     '12345678901', '1998/02/21', 'Rua Urubu, 123',        '1194567890', 'M'),
(100022, 'Camila Oliveira',   '23456789012', '1991/02/21', 'Rua Flamengo, 456',     '1195678901', 'F'),
(100023, 'Lucas Costa',       '34567890123', '1993/02/21', 'Rua das Flores, 789',   '1196789012', 'M'),
(100024, 'Ana Souza',         '45678901234', '1994/02/11', 'Rua do Brasil, 012',    '1197890123', 'F'),
(100025, 'Marcos Pereira',    '56789012345', '1994/02/07', 'Avenida de Todos, 35',  '1198901234', 'M'),
(100026, 'Sara Mendes',       '67890123456', '1994/02/01', 'Rua Koo, 678',          '1199012345', 'F'),
(100027, 'Renan Rodrigues',   '78901234567', '1994/02/12', 'Rua Cristina Lee, 901', '1190123456', 'M'),
(100028, 'Luana Almeida',     '89012345678', '1994/02/20', 'Rua Projetada, 234',    '1191234567', 'F'),
(100029, 'Diego Silva',       '90123456789', '1991/04/15', 'Avenida Vasco, 567',    '1192345678', 'M'),
(100030, 'Carla Oliveira',    '01234567890', '1999/12/12', 'Rua Godilho, 80',       '1193456789', 'F');


--TABLE_PROFESSOR--
SELECT * FROM professor;
INSERT INTO professor (id_professor, nome_professor, cpf_professor, data_nasc_professor, end_professor, fone_professor, gender_professor) VALUES
(0101, 'Naulo dos Santos',   '09876543210', '1979-03-22', 'Rua Amargos, 12',            '1197654321', 'M'),
(0102, 'Neymar Suares',      '98765432109', '1989-11-05', 'Rua Indaiá, 456',            '2196543210', 'F'),
(0103, 'Pedro Oliveira',     '87654321098', '1964-05-01', 'Avenida Castellanos, 789',   '1195432109', 'M'),
(0104, 'Laura Mendes',       '76543210987', '1945-07-19', 'Rua Chaves, 12',             '1194321098', 'F'),
(0105, 'Washingtom Almeida', '65432109876', '1990-07-29', 'Rua Edward Tesoura, 05',     '1193210987', 'F'),
(0106, 'Carlos Costa',       '54321098765', '1981-02-12', 'Avenida Lourenço, Apto. 62', '1192109876', 'M');


--TABLE_MATERIA--
SELECT * FROM materia;
INSERT INTO materia (id_materia, nome_materia) VALUES
(901, 'Legislação de Trânsito'),
(902, 'Direção Defensiva'),
(903, 'Primeiros Socorros'),
(904, 'Meio Ambiente e Cidadania'),
(905, 'Noções de Mecânica Básica');

--TABLE_REPERTORIO_ALUNO-- (10 primeiros alunos)
SELECT * FROM repertorio_aluno;
INSERT INTO repertorio_aluno (id_report_aluno, ra_aluno, id_materia, faltas_aluno, situacao_aluno) VALUES
(810101, 100001, 901, 2, 'REPROVADO'),
(810102, 100001, 902, 4, 'REPROVADO'),
(810103, 100001, 903, 3, 'REPROVADO'),
(810104, 100001, 904, 3, 'REPROVADO'),
(810105, 100001, 905, 3, 'APROVADO'),
(810106, 100002, 901, 3, 'APROVADO'),
(810107, 100002, 902, 0, 'APROVADO'),
(810108, 100002, 903, 2, 'APROVADO'),
(810109, 100002, 904, 5, 'APROVADO'),
(810110, 100002, 905, 1, 'APROVADO'),
(810111, 100003, 901, 6, 'APROVADO'),
(810112, 100003, 902, 3, 'APROVADO'),
(810113, 100003, 903, 4, 'APROVADO'),
(810114, 100003, 904, 2, 'APROVADO'),
(810115, 100003, 905, 0, 'APROVADO'),
(810116, 100004, 901, 1, 'REPROVADO'),
(810117, 100004, 902, 5, 'APROVADO'),
(810118, 100004, 903, 0, 'APROVADO'),
(810119, 100004, 904, 4, 'APROVADO'),
(810120, 100004, 905, 2, 'APROVADO'),
(810121, 100005, 901, 3, 'APROVADO'),
(810122, 100005, 902, 1, 'APROVADO'),
(810123, 100005, 903, 5, 'APROVADO'),
(810124, 100005, 904, 0, 'APROVADO'),
(810125, 100005, 905, 6, 'APROVADO'),
(810126, 100006, 901, 4, 'APROVADO'),
(810127, 100006, 902, 2, 'APROVADO'),
(810128, 100006, 903, 1, 'REPROVADO'),
(810129, 100006, 904, 3, 'APROVADO'),
(810130, 100006, 905, 5, 'APROVADO'),
(810131, 100007, 901, 2, 'CURSANDO'),
(810132, 100007, 902, 4, 'CURSANDO'),
(810133, 100007, 903, 3, 'CURSANDO'),
(810134, 100007, 904, 3, 'CURSANDO'),
(810135, 100007, 905, 3, 'CURSANDO'),
(810136, 100008, 901, 3, 'CURSANDO'),
(810137, 100008, 902, 0, 'CURSANDO'),
(810138, 100008, 903, 5, 'CURSANDO'),
(810139, 100008, 904, 1, 'CURSANDO'),
(810140, 100008, 905, 6, 'CURSANDO'),
(810141, 100009, 901, 4, 'CURSANDO'),
(810142, 100009, 902, 2, 'CURSANDO'),
(810143, 100009, 903, 1, 'CURSANDO'),
(810144, 100009, 904, 3, 'CURSANDO'),
(810145, 100009, 905, 5, 'CURSANDO'),
(810146, 100010, 901, 1, 'CURSANDO'),
(810147, 100010, 902, 5, 'CURSANDO'),
(810148, 100010, 903, 0, 'CURSANDO'),
(810149, 100010, 904, 4, 'CURSANDO'),
(810150, 100010, 905, 2, 'CURSANDO');

--TABLE_TURMA--
SELECT * FROM turma;
INSERT INTO turma (id_turma, periodo_turma) VALUES
('1A', 'MATUTINO'     ),
('2A', 'MATUTINO'     ),
('1B', 'VESPERTINO'   ),
('2B', 'VESPERTINO'   ),
('3A', 'NOTURNO'      ),
('3B', 'NOTURNO'      );

--TABLE_TURMA_ALUNO--
SELECT * FROM turma_aluno;
INSERT INTO turma_aluno (id_turma_aluno, id_turma, ra_aluno) VALUES
(101, '1A', 100001),
(102, '1A', 100002),
(103, '1A', 100003),
(104, '1A', 100004),
(105, '1A', 100005),
(106, '1A', 100006),
(107, '1A', 100007),
(108, '2A', 100008),
(109, '2A', 100009),
(110, '2A', 100010),
(111, '3A', 100011),
(112, '3A', 100012),
(113, '3A', 100013),
(114, '3A', 100014),
(115, '3A', 100015),
(116, '1B', 100016),
(117, '1B', 100017),
(118, '1B', 100018),
(119, '1B', 100019),
(120, '1B', 100020),
(121, '2B', 100021),
(122, '2B', 100022),
(123, '2B', 100023),
(124, '2B', 100024),
(125, '2B', 100025),
(126, '3B', 100026),
(127, '3B', 100027),
(128, '3B', 100028),
(129, '3B', 100029),
(130, '3B', 100030);

--TABLE_AULA--
SELECT * FROM aula;
INSERT INTO aula(id_aula, id_turma, id_professor, id_materia) VALUES
(1,  '1A', 0102, 901),
(2,  '1A', 0104, 905),
(3,  '1A', 0104, 905),
(4,  '1A', 0102, 901),
(5,  '1A', 0102, 903),
(6,  '2A', 0104, 905),
(7,  '2A', 0103, 903),
(8,  '2A', 0102, 905),
(9,  '2A', 0102, 905),
(10, '2A', 0102, 904),
(11, '3A', 0104, 903),
(12, '3A', 0104, 905),
(13, '3A', 0102, 901),
(14, '3A', 0104, 905),
(15, '3A', 0102, 905),
(16, '1B', 0102, 901),
(17, '1B', 0101, 903),
(18, '1B', 0104, 905),
(19, '1B', 0101, 904),
(20, '1B', 0102, 902),
(21, '2B', 0102, 902),
(22, '2B', 0102, 901),
(23, '2B', 0103, 903),
(24, '2B', 0105, 902),
(25, '2B', 0104, 904),
(26, '3B', 0105, 902),
(27, '3B', 0103, 902),
(28, '3B', 0102, 901),
(29, '3B', 0106, 901),
(30, '3B', 0106, 902);

--TABLE_REPOSICAO_AULA--
SELECT * FROM reposicao_aula;
INSERT INTO reposicao_aula (id_reposicao_aula, id_aula, reposicao_data, reposicao_periodo) VALUES
(1,1,'2023-07-01', 'MATUTINO'),
(2,3,'2023-07-08', 'NOTURNO'),
(3,4,'2023-07-15', 'VESPERTINO');

----------------------------__________SELECT_TABLES__________----------------------------


--SELECIONAR TODOS OS ALUNOS DE CADA PERÍODO
--MATUTINO
SELECT aluno.nome_aluno AS aluno, turma.id_turma AS código_turma, turma.periodo_turma AS período
FROM aluno
INNER JOIN turma_aluno
ON aluno.ra_aluno = turma_aluno.ra_aluno
INNER JOIN turma
ON turma_aluno.id_turma = turma.id_turma
WHERE periodo_turma = 'MATUTINO'

--VESPERTINO
SELECT aluno.nome_aluno AS aluno, turma.id_turma AS código_turma, turma.periodo_turma AS período
FROM aluno
INNER JOIN turma_aluno
ON aluno.ra_aluno = turma_aluno.ra_aluno
INNER JOIN turma
ON turma_aluno.id_turma = turma.id_turma
WHERE periodo_turma = 'VESPERTINO'

--NOTURNO
SELECT aluno.nome_aluno AS aluno, turma.id_turma AS código_turma, turma.periodo_turma AS período
FROM aluno
INNER JOIN turma_aluno
ON aluno.ra_aluno = turma_aluno.ra_aluno
INNER JOIN turma
ON turma_aluno.id_turma = turma.id_turma
WHERE periodo_turma = 'NOTURNO'


--IDENTIFICAR A QUANTIDADE DE AULAS MINISTRADAS POR PROFESSOR.
SELECT professor.nome_professor AS Professor, COUNT(aula.id_aula) AS Aulas_Ministradas
FROM professor
LEFT JOIN aula ON professor.id_professor = aula.id_professor
GROUP BY professor.id_professor;

--IDENTIFIQUE A QUANTIDADE DE MATÉRIAS QUE CADA PROFESSOR OFERECE.
SELECT professor.nome_professor AS professor, COUNT (DISTINCT aula.id_materia) AS Matérias
FROM aula 
INNER JOIN professor
ON aula.id_professor = professor.id_professor
GROUP BY professor.nome_professor

--IDENTIFICAR TODOS OS ALUNOS DE CADA GÊNERO QUE ESTÃO APROVADOS EM CADA MATÉRIA.
--FEMININO
SELECT aluno.nome_aluno AS aluno, materia.nome_materia, aluno.gender_aluno AS sexo, repertorio_aluno.situacao_aluno AS situação
FROM materia
INNER JOIN repertorio_aluno
ON materia.id_materia = repertorio_aluno.id_materia
INNER JOIN aluno
ON repertorio_aluno.ra_aluno = aluno.ra_aluno
WHERE repertorio_aluno.situacao_aluno = 'APROVADO'
AND aluno.gender_aluno = 'F' 

--MASCULINO
SELECT aluno.nome_aluno AS aluno, materia.nome_materia, aluno.gender_aluno AS sexo, repertorio_aluno.situacao_aluno AS situação
FROM materia
INNER JOIN repertorio_aluno
ON materia.id_materia = repertorio_aluno.id_materia
INNER JOIN aluno
ON repertorio_aluno.ra_aluno = aluno.ra_aluno
WHERE repertorio_aluno.situacao_aluno = 'APROVADO'
AND aluno.gender_aluno = 'M' 

--SELECIONAR OS ALUNOS QUE ESTÃO APROVADOS NO CURSO (APROVADOS EM TODAS MATÉRIAS)
SELECT aluno.nome_aluno, repertorio_aluno.ra_aluno 
FROM aluno
INNER JOIN repertorio_aluno
ON aluno.ra_aluno = repertorio_aluno.ra_aluno
WHERE repertorio_aluno.ra_aluno IN (
  SELECT ra_aluno
  FROM repertorio_aluno
  WHERE situacao_aluno = 'APROVADO'
  GROUP BY ra_aluno
  HAVING COUNT(DISTINCT id_materia) = (
    SELECT COUNT(DISTINCT id_materia)
    FROM repertorio_aluno
    WHERE situacao_aluno = 'APROVADO'
  )
)
GROUP BY repertorio_aluno.ra_aluno, aluno.nome_aluno;


--SELECIONAR OS ALUNOS QUE NÃO FORAM APROVADOS NO CURSO
SELECT DISTINCT aluno.nome_aluno, repertorio_aluno.ra_aluno
FROM aluno
INNER JOIN repertorio_aluno
ON aluno.ra_aluno = repertorio_aluno.ra_aluno
WHERE repertorio_aluno.ra_aluno IN (
  SELECT ra_aluno
  FROM repertorio_aluno
  WHERE situacao_aluno = 'REPROVADO'
)
AND repertorio_aluno.ra_aluno IN (
  SELECT ra_aluno
  FROM repertorio_aluno
  WHERE situacao_aluno = 'APROVADO'
);

--SELECIONAR OS ALUNOS QUE AINDA ESTÃO CURSANDO
SELECT aluno.nome_aluno, repertorio_aluno.ra_aluno
FROM aluno
INNER JOIN repertorio_aluno
ON aluno.ra_aluno = repertorio_aluno.ra_aluno
WHERE repertorio_aluno.ra_aluno IN (
  SELECT ra_aluno
  FROM repertorio_aluno
  WHERE situacao_aluno = 'CURSANDO'
  GROUP BY ra_aluno
  HAVING COUNT(DISTINCT id_materia) = (
    SELECT COUNT(DISTINCT id_materia)
    FROM repertorio_aluno
    WHERE situacao_aluno = 'CURSANDO'
  )
)
GROUP BY repertorio_aluno.ra_aluno, aluno.nome_aluno;











