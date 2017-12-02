Program EQ04N02 ;

// ALUNOS: CLAUDINEI VARELA, DIEGO LEMOS, MATHEUS MACEDO//

uses crt,noite;

var
reg:string[60]; // V�RIAVEL QUE CONT�M TODAS AS INFORMA��ES DE CADA CANDIDATO DO ARQUIVO CADAST.TXT
reg2:regis;   // V�RIAVEL AONDE SER�O GRAVADAS TODAS AS INFORMA��ES DE CADA CANDIDATO DO ARQUIVO CADAST.FIM
arq2:file of regis;   // VARIAVEL PARA MANIPULA��O DE CADAST. FIM
e:Integer;    // VARIAVEL DE ERRO UTILIZADO PARA CONVERS�O DOS INTEIROS EM STRING
arq:text; // VARIAVEL PARA MANIPULA��O DE CADAST.TXT

procedure cabeca; // PROCEDIMENTO DE MENU
 begin
 	clrscr ;
 	Writeln('==================================================================');
 	Writeln('                CANDIDATOS CADASTRADOS - ENLATADOS');
 	Writeln('==================================================================');
 	Writeln('NUM |N O M E                             |   C P F   | DAT NASC |C');
 end;

begin
	Assign(arq,'CADAST.txt');   // ABRE ARQUIVO CADAST.TXT
	Assign(arq2,'CADAST.FIM');  // ABRE ARQUIVO CADAST.FIM
	CABECA;
	Reset(arq); // USADO PARA ABRIR ARQUIVOS J� EXISTENTES, POSICIONANDO O CURSOR NO IN�CIO DO ARQUIVO CADAST.TXT
	Rewrite(arq2); // USADO PARA ABRIR ARQUIVO PARA ESCRITA 
	Reset(arq2); // POSICIONA O CURSOR NO IN�CIO DO ARQUIVO CADAST.FIM
		While not (eof (arq)) do    // ENQUANTO N�O CHEGAR AO FIM DE CADAST.FIM
		 begin
			Readln(arq,reg);
			val(copy(reg,1,4),reg2.num,e);
			reg2.nome := copy(reg,5,36); // COPIA A PARTIR DO CARACTERE 5 DA STRING REG (DE 60 CARACTERES) OS PR�XIMOS 36 CARACTERES QUE SE REFEREM AO NOME DO CANDIDATO E INSERE EM REG2.NOME
			reg2.cpf := copy(reg,41,11); // COPIA A PARTIR DO CARACTERE 41 DA STRING REG OS PR�XIMOS 11 CARACTERES QUE SE REFEREM AO CPF DO CANDIDATO  E INSERE EM REG2.CPF
			insert (copy(reg,52,2), reg2.data, 1); // INSERE A C�PIA DOS CARACTERES 52 E 53 (DIA DE NASCIMENTO) EM REG2.DATA NA �LTIMA POSI��O   E INSERE EM REG2.DATA
  		insert (copy(reg,54,2), reg2.data, 1); // INSERE A C�PIA DOS CARACTERES 54 E 56 (M�S DE NASCIMENTO) EM REG2.DATA NA �LTIMA POSI��O (AP�S DIA) E INSERE EM REG2.DATA
  		insert (copy(reg,56,4), reg2.data, 1); // INSERE A C�PIA DOS CARACTERES 56 A 59 (ANO DE NASCIMENTO) EM REG2.DATA NA �LTIMA POSI��O  (AP�S M�S) E INSERE EM REG2.DATA
			val(copy(reg,60,1),reg2.car,e);// CONVERTE A �LTIMO CARACTERE QUE � INTEIRO PARA STRING E E INSERE EM REG2.DATA EM REG2.CAR
			Writeln(copy(reg,1,4),' ',reg2.nome:36,' ',reg2.cpf:11,' ',copy(reg2.data,7,2),'/',   // ESCREVE NA TELA N�MERO DE INSCRI��O/ NOME/ CPF/DATA DE NASCIMENTO/ CARGO
			   copy(reg2.data,5,2),'/',copy(reg2.data,1,4),' ',reg2.car:1);
			
			Write(arq2,reg2); // GRAVA TODA A STRING EM CADAST.FIM
		 end;                                          
	

	close(arq2); // FECHA CADAST.FIM

	close(arq); // FECHA CADAS.TXT
	Writeln();
	Writeln();
	Write('Tecle [ENTER] para encerrar.');
	Readln;		
  
End.