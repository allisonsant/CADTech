#Não deixe de alterar a senha e o banco de dados em que o programa está se conectando...
import PySimpleGUI as sg
import psycopg2

def limpar():
        window['-RA-'].update('')
        window['-NOME DO ALUNO-'].update('')
        window['-CPF-'].update('')
        window['-DATA DE NASCIMENTO-'].update('')
        window['-ENDEREÇO-'].update('')
        window['-FONE-'].update('')
        window['-GENERO-F-'].update(True)
        
def atualiza():
        
        if len(lista) == 0:
            limpar()
        else:
            window['-RA-'].update( lista[indice][0] )
            window['-NOME DO ALUNO-'].update( lista[indice][1] )
            window['-CPF-'].update( lista[indice][2] )
            window['-DATA DE NASCIMENTO-'].update( lista[indice][3] )
            window['-ENDEREÇO-'].update( lista[indice][4] )
            window['-FONE-'].update( lista[indice][5] )
            if lista[indice][6]: window['-GENERO-M-'].update(True)
            else: window['-GENERO-F-'].update(True)
        
def todos():
        
        global indice
        global lista
        resposta = []
        with con:
            with con.cursor() as cursor:
                cursor.execute("SELECT * FROM aluno;")
                resposta = cursor.fetchall()
        lista.clear()
        listaString = ''
        for i in range(len(resposta)):
            lista.append( list(resposta[i]) )
            lista[i][6] = True if lista[i][6] == 'M' else False
            listaString += str(i+1) +') ' + resposta[i][1] + '\n'
        sg.popup('Resultado:\n\n' + listaString)
        # sg.popup('Quantidade de registros: ' + str(len(resposta)))
        indice = 0
        atualiza()

con = psycopg2.connect(host="localhost", database="bd_cadtech", user="postgres", password="123456")
cursor = con.cursor()
    # Inicialização BD
lista=[]
indice = 0

layout = [
            [
                sg.Text("RA:", size=(8, 1)),
                sg.InputText(size=(36, 1), key="-RA-", focus=True)
            ],
            [
                sg.Text("Nome Aluno:", size=(9, 1)),
                sg.InputText(size=(35, 1), key="-NOME DO ALUNO-", focus=True)
            ],
            [
                sg.Text("CPF:", size=(8, 1)),
                sg.InputText(size=(36, 1), key="-CPF-")
            ],
            [
                sg.Text("Data de Nascimento:", size=(15, 1)),
                sg.InputText(size=(28, 1), key="-DATA DE NASCIMENTO-")
            ],
            [
                sg.Text("Endereço:", size=(8, 1)),
                sg.InputText(size=(36, 1), key="-ENDEREÇO-", focus=True)
            ],
            [
                sg.Text("Celular:", size=(8, 1)),
                sg.InputText(size=(36, 1), key="-FONE-")
            ],
            [
                sg.Text("Gênero:", size=(8, 1)),
                sg.Radio('Masculino', 'GRUPO1', default=False, key="-GENERO-M-"),
                sg.Radio('Feminino', 'GRUPO1', default=True, key="-GENERO-F-")
            ],
            [
                sg.Button('Limpar', size=(8, 1), key="-LIMPAR-"),
                sg.Button('Inserir', size=(8, 1), key="-INSERIR-"),
                sg.Button('Atualizar', size=(8, 1), key="-ATUALIZAR-"),
                sg.Button('Remover', size=(8, 1), key="-REMOVER-")
            ],
            [
                sg.Button('<<', size=(8, 1), key="-<<-"),
                sg.Button('Procurar', size=(8, 1), key="-PROCURAR-"),
                sg.Button('Todos', size=(8, 1), key="-TODOS-"),
                sg.Button('>>', size=(8, 1), key="->>-")
            ]
        ]    
    
window = sg.Window("Cadastro dos Alunos", layout, use_default_focus=False)

   
    # Run the Event Loop
while True:
    event, values = window.read()

    if event == sg.WIN_CLOSED:
        break
    elif event == "-LIMPAR-":
        limpar()
    elif event == "-INSERIR-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("INSERT INTO aluno (ra_aluno, nome_aluno, cpf_aluno, data_nasc_aluno, end_aluno, fone_aluno, gender_aluno) VALUES (%s, %s, %s, %s, %s, %s, %s);",
                    (values['-RA-'],values['-NOME DO ALUNO-'], values['-CPF-'],values['-DATA DE NASCIMENTO-'], values['-ENDEREÇO-'], values['-FONE-'], ('M' if values['-GENERO-M-'] else 'F')))
        limpar()
    elif event == "-ATUALIZAR-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("UPDATE aluno SET ra_aluno = %s, nome_aluno = %s, cpf_aluno = %s, data_nasc_aluno = %s, end_aluno = %s, fone_aluno = %s,gender_aluno = %s WHERE ra_aluno = %s",
                    (values['-NOME DO ALUNO-'], values['-CPF-'],values['-DATA DE NASCIMENTO-'], values['-ENDEREÇO-'], values['-FONE-'], ('M' if values['-GENERO-M-'] else 'F'),lista[indice][0]))
        lista[indice] = [lista[indice][0], values['-NOME DO ALUNO-'], values['-CPF-'], values['-DATA DE NASCIMENTO-'], values['-ENDEREÇO-'], values['-FONE-'], values['-GENERO-M-']]        
    elif event == "-REMOVER-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("DELETE FROM aluno WHERE ra_aluno = %s", (lista[indice][0],))
        lista.pop(indice)
        indice -= 1
        atualiza()
    elif event == "-PROCURAR-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("SELECT * FROM aluno WHERE nome_aluno LIKE %s;",
                    ('%'+values['-NOME DO ALUNO-']+'%',))
                resposta = cursor.fetchall()
                lista.clear()
                listaString = ''
                for i in range(len(resposta)):
                    lista.append( list(resposta[i]) )
                    lista[i][6] = True if lista[i][6] == 'M' else False
                    listaString += str(i+1) +') ' + resposta[i][1] + '\n'
                sg.popup('Resultado:\n\n' + listaString)
                indice = 0
                atualiza()
    elif event == "-TODOS-":
        todos()
    elif event == "->>-":
        indice += 1
        if indice >= len(lista): indice = len(lista)-1
        atualiza()
    elif event == "-<<-":
        indice -= 1
        if indice <= 0: indice = 0
        atualiza()

window.close()

# Fazer as mudanças para a base persistente
con.commit()

# Fechar a comunicação com o servidor
cursor.close()
con.close()


def conectar_bd():
    conn = psycopg2.connect(
        host="localhost",
        database="bd_cadtech",
        user="postgres",
        password="123456")
    return conn

def mostrar_registros():
    conn = conectar_bd()
    cursor = conn.cursor()

    # Obter todos os registros da tabela situacao_aula
    #cursor.execute("SELECT * FROM repertorio_aluno")
    cursor.execute("SELECT aluno.nome_aluno,  repertorio_aluno.id_report_aluno, aluno.ra_aluno, materia.nome_materia, repertorio_aluno.faltas_aluno, repertorio_aluno.situacao_aluno FROM aluno INNER JOIN repertorio_aluno ON aluno.ra_aluno = repertorio_aluno.ra_aluno INNER JOIN materia ON repertorio_aluno.id_materia = materia.id_materia")
    registros = cursor.fetchall()

    # Criar layout da nova janela para exibir os registros
    layout = [
        [sg.Table(values=[list(registro) for registro in registros],
                  headings=["Nome Aluno", "ID Repertorio Aluno"," Ra Aluno","Matéria", "Faltas Aluno", "Situação Aluno"],
                  auto_size_columns=True, display_row_numbers=True, justification='center')],
        [sg.Button("Fechar")]
    ]

    window = sg.Window("Registros", layout)

    while True:
        event, _ = window.read()
        if event == sg.WINDOW_CLOSED or event == "Fechar":
            break

    window.close()


def inserir_registro(values):
    # Obter os valores dos campos
    ra_aluno = int(values['ra_aluno'])
    id_materia = get_id_materia(values['id_materia'])
    faltas_aluno = int(values['faltas_aluno'])
    situacao_aluno = values['situacao_aluno']

    # Conectar ao banco de dados
    conexao = psycopg2.connect(
    host="localhost",
    database="bd_cadtech",
    user="postgres",
    password="123456"
        )
    cursor = conexao.cursor()

    # Inserir o registro na tabela
    comando_sql = "INSERT INTO repertorio_aluno (ra_aluno, id_materia, faltas_aluno, situacao_aluno) VALUES (%s, %s, %s, %s)"
    valores = (ra_aluno, id_materia, faltas_aluno, situacao_aluno)
    cursor.execute(comando_sql, valores)

    # Confirmar as alterações e encerrar a conexão
    conexao.commit()
    cursor.close()
    conexao.close()

    sg.popup("Registro inserido com sucesso!")


        

def remover_registro(ra_aluno):
    # Verificar se o campo RA do aluno foi preenchido
    if ra_aluno:
        # Conectar ao banco de dados
        conexao = psycopg2.connect(
        host="localhost",
        database="bd_cadtech",
        user="postgres",
        password="123456"
         )
        cursor = conexao.cursor()

        # Remover o registro da tabela
        comando_sql = "DELETE FROM repertorio_aluno WHERE ra_aluno = %s"
        cursor.execute(comando_sql, (int(ra_aluno),))

        # Confirmar as alterações e encerrar a conexão
        conexao.commit()
        cursor.close()
        conexao.close()

        sg.popup("Registro removido com sucesso!")
    else:
        sg.popup("Campo RA do aluno vazio!")

def buscar_registro(ra_aluno):

    conexao = psycopg2.connect(
    host="localhost",
    database="bd_cadtech",
    user="postgres",
    password="123456"
        )
    cursor = conexao.cursor()

    # Buscar o registro na tabela
    comando_sql = "SELECT * FROM  repertorio_aluno WHERE ra_aluno = %s"
    cursor.execute(comando_sql, (ra_aluno,))
    registro = cursor.fetchone()

    if registro is not None:
        # Exibir os dados do registro nos campos correspondentes da tela
        window['id_materia'].update(get_chave_id_materia(registro[2]))
        window['faltas_aluno'].update(registro[3])
        window['situacao_aluno'].update(registro[4])
    else:
        sg.popup("Registro não encontrado!")
    # Encerrar a conexão
    cursor.close()
    conexao.close()

def atualizar_registro(ra_aluno, values):
    if ra_aluno:
        conexao = psycopg2.connect(
        host="localhost",
        database="bd_cadtech",
        user="postgres",
        password="123456"
            )
        cursor = conexao.cursor()
        

        id_materia = get_id_materia(values['id_materia'])
        faltas_aluno = int(values['faltas_aluno'])
        situacao_aluno = values['situacao_aluno']

        comando_sql = "UPDATE repertorio_aluno SET id_materia = %s, faltas_aluno = %s, situacao_aluno = %s WHERE ra_aluno = %s"
        cursor.execute(comando_sql, (id_materia, faltas_aluno, situacao_aluno, ra_aluno))

        conexao.commit()
        cursor.close()
        conexao.close()
        sg.popup("Registro atualizado com sucesso!")
    else:
        sg.popup("Campo RA do aluno vazio!")


def get_id_materia(chave):
    if chave == 'Legislação de Trânsito':
        return 901
    elif chave == 'Direção Defensiva':
        return 902
    elif chave == 'Primeiros Socorros':
        return 903
    elif chave == 'Meio Ambiente e Cidadania':
        return 904
    elif chave == 'Noções de Mecânica Básica':
        return 905
    else:
        return None

def get_chave_id_materia(id_materia):
    # Código para mapear o id_materia para a chave...
    chaves = {
        901: 'Legislação de Trânsito',
        902: 'Direção Defensiva',
        903: 'Primeiros Socorros',
        904: 'Meio Ambiente e Cidadania',
        905: 'Noções de Mecânica Básica'
    }
    return chaves.get(id_materia, '')

# Exemplo de uso

# criar_tabela()  # Executar apenas uma vez para criar a tabela


layout_dois = [
    [sg.Text('RA Aluno:', size=(8, 1)), sg.Input(size=(44, 1), key='ra_aluno')],
    [sg.Text('Matéria:', size=(9, 1)), sg.Combo(['Legislação de Trânsito', 'Direção Defensiva', 'Primeiros Socorros', 'Meio Ambiente e Cidadania', 'Noções de Mecânica Básica'],size=(41, 1), key='id_materia')],
    [sg.Text('Faltas Aluno:', size=(10, 1)), sg.Input(size=(42, 1), key='faltas_aluno')],
    [sg.Text('Situação Aluno:', size=(12, 1)), sg.Combo(['APROVADO', 'REPROVADO', 'CURSANDO'],size=(38, 1), key='situacao_aluno')],
    [sg.Button('Inserir Registro', size=(8, 2)), sg.Button('Remover Registro', size=(8, 2)), sg.Button('Buscar Registro', size=(8, 2)), sg.Button('Atualizar Registro', size=(8, 2)), sg.Button("Mostrar Registros", size=(8, 2))],
]
window = sg.Window('Repertorio Aluno', layout_dois)
while True:
        event, values = window.read()
        if event == sg.WINDOW_CLOSED:
            break
        elif event == "Inserir Registro":
            inserir_registro(values)
        elif event == "Remover Registro":
            ra_aluno = int(values['ra_aluno'])
            remover_registro(ra_aluno)
        elif event == "Buscar Registro":
            ra_aluno = int(values['ra_aluno'])
            buscar_registro(ra_aluno)
        elif event == "Atualizar Registro":
            ra_aluno = int(values['ra_aluno'])
            atualizar_registro(ra_aluno, values)
        elif event == "Mostrar Registros":
            mostrar_registros()

window.close()