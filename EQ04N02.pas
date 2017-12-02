Program EQ04N02 ;

// ALUNOS: CLAUDINEI VARELA, DIEGO LEMOS, MATHEUS MACEDO//

uses crt,noite;

var
reg:string[60]; // VÁRIAVEL QUE CONTÉM TODAS AS INFORMAÇÕES DE CADA CANDIDATO DO ARQUIVO CADAST.TXT
reg2:regis;   // VÁRIAVEL AONDE SERÃO GRAVADAS TODAS AS INFORMAÇÕES DE CADA CANDIDATO DO ARQUIVO CADAST.FIM
arq2:file of regis;   // VARIAVEL PARA MANIPULAÇÃO DE CADAST. FIM
e:Integer;    // VARIAVEL DE ERRO UTILIZADO PARA CONVERSÃO DOS INTEIROS EM STRING
arq:text; // VARIAVEL PARA MANIPULAÇÃO DE CADAST.TXT

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
	Reset(arq); // USADO PARA ABRIR ARQUIVOS JÁ EXISTENTES, POSICIONANDO O CURSOR NO INÍCIO DO ARQUIVO CADAST.TXT
	Rewrite(arq2); // USADO PARA ABRIR ARQUIVO PARA ESCRITA 
	Reset(arq2); // POSICIONA O CURSOR NO INÍCIO DO ARQUIVO CADAST.FIM
		While not (eof (arq)) do    // ENQUANTO NÃO CHEGAR AO FIM DE CADAST.FIM
		 begin
			Readln(arq,reg);
			val(copy(reg,1,4),reg2.num,e);
			reg2.nome := copy(reg,5,36); // COPIA A PARTIR DO CARACTERE 5 DA STRING REG (DE 60 CARACTERES) OS PRÓXIMOS 36 CARACTERES QUE SE REFEREM AO NOME DO CANDIDATO E INSERE EM REG2.NOME
			reg2.cpf := copy(reg,41,11); // COPIA A PARTIR DO CARACTERE 41 DA STRING REG OS PRÓXIMOS 11 CARACTERES QUE SE REFEREM AO CPF DO CANDIDATO  E INSERE EM REG2.CPF
			insert (copy(reg,52,2), reg2.data, 1); // INSERE A CÓPIA DOS CARACTERES 52 E 53 (DIA DE NASCIMENTO) EM REG2.DATA NA ÚLTIMA POSIÇÃO   E INSERE EM REG2.DATA
  		insert (copy(reg,54,2), reg2.data, 1); // INSERE A CÓPIA DOS CARACTERES 54 E 56 (MÊS DE NASCIMENTO) EM REG2.DATA NA ÚLTIMA POSIÇÃO (APÓS DIA) E INSERE EM REG2.DATA
  		insert (copy(reg,56,4), reg2.data, 1); // INSERE A CÓPIA DOS CARACTERES 56 A 59 (ANO DE NASCIMENTO) EM REG2.DATA NA ÚLTIMA POSIÇÃO  (APÓS MÊS) E INSERE EM REG2.DATA
			val(copy(reg,60,1),reg2.car,e);// CONVERTE A ÚLTIMO CARACTERE QUE É INTEIRO PARA STRING E E INSERE EM REG2.DATA EM REG2.CAR
			Writeln(copy(reg,1,4),' ',reg2.nome:36,' ',reg2.cpf:11,' ',copy(reg2.data,7,2),'/',   // ESCREVE NA TELA NÚMERO DE INSCRIÇÃO/ NOME/ CPF/DATA DE NASCIMENTO/ CARGO
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