Program EQ04N03;  // PROGRAMA QUE ABRE O ARQUIVO CADAST.FIM E PERMITE O USU�RIO ORDENAR OS CANDIDATOS POR: INSCRI��O, NOME,CPF E DATA

// ALUNOS: CLAUDINEI VARELA, DIEGO LEMOS, MATHEUS MACEDO//

uses crt,NOITE;

var
numaux:string[4];
opcao:string[1]; // V�RIAVEL QUE RECEBE OP��O DE ORDENA��O ESCOLHIDA PE�O CANDIDATO
reg2:regis; // TIPO DE REGISTRO QUE CONT�M TODAS AS INFORMA��ES DE INSCRI��O DE CADA CANDIDATO
arq2:file of regis; // VARIAVEL PARA MANIPULA��O DE CADAST.FIM
opcaoaux,a,i,e,cont:Integer;
vetortop:cc;  // VETOR QUE CONT�M OS CAMPOS .PF E .C_CHAVE                
vetorsupertop:vetor;  // VETOR QUE RECEBE O CONTE�DO DE REG3.C_CHAVE E � UTILIZADO COMO PARAMETRO PARA ORDENA��O DA FUN��O ORDEM DA UNIT NOITE        

begin
repeat
	Writeln(' Escolha uma op��o de ordena��o.');
	Writeln(' [1] Ordena��o por INSCRI��O.');
	Writeln(' [2] Ordena��o por NOME.');
	Writeln(' [3] Ordena��o por CPF.');
	Writeln(' [4] Ordena��o por DATA.');
	readln (opcao);  // V�RIAVEL QUE RECEBE OP��O DE ORDENA��O ESCOLHIDA PE�O CANDIDATO.
	val(opcao,opcaoaux,e); // CONVERTE OP��O(STRING) PARA OPCAOAUX(INTEIRO) PARA QUE SEJAM FEITAS AS VALIDA��ES
	 If (opcaoaux >4) or (opcaoaux <1)  then
		begin
			Writeln('Op��o INV�LIDA. Digite um n�mero [1 a 4]');
			e:=1;
			clrscr;
		end;
Until (opcaoaux>0) and (opcaoaux <5) and (e=0);  // REPETE O �NICIO DO PROGRAMA AT� QUE A OP��OAUX SEJA UM VALOR ENTRE 1 E 4

	Assign(arq2,'CADAST.FIM');  // ABRE ARQUIVO CADAST.FIM
	Reset(arq2); // POSICIONA O CURSOR NO IN�CIO DO ARQUIVO CADAST.FIM 
	 While not eof (arq2) do  // ENQUANTO N�O CHEGAR AT� O FINAL DE CADAST.FIM
		 begin
		 	Read(arq2,reg2);  // L� REG2( STRING DE 60) QUE CONT�M TODAS AS INFORMA��ES DE CADA CANDIDATO 
		 	vetortop.pf:=cont;
				if (opcaoaux=1) then  //SE OP�AO ESCOLHIDA FOR IGUAL A 1 ,VETORTOP.C_CHAVE RECEBE N�MERO DE INSCRI��O DO CANDIDATO
					begin
					 str (reg2.num:4,numaux); // CONVERTE N�MERO DE INSCRI��O DO CANDIDATO PARA STRING
					 vetortop.C_CHAVE:=numaux; 	
		      end;
			    if (opcaoaux=2) then //SE OP�AO ESCOLHIDA FOR IGUAL A 2 , VETORTOP.C_CHAVE RECEBE NOME DO CANDIDATO
			     begin
				 	   vetortop.C_CHAVE:=reg2.nome;		
		       end;
					  if (opcaoaux=3) then //SE OP�AO ESCOLHIDA FOR IGUAL A 3, VETORTOP.C_CHAVE RECEBE N�MERO DE CPF DO CANDIDATO
			       begin
			        vetortop.C_CHAVE:=reg2.cpf;	
		 				 end;
						  if (opcaoaux=4) then //SE OP�AO ESCOLHIDA FOR IGUAL A 4 , VETORTOP.C_CHAVE RECEBE DATA DE NASCIMENTO (ANO/M�S/DIA) DO CANDIDATO
		           begin
							  vetortop.C_CHAVE:=reg2.data;
						   end;
										 
        cont := cont +1;
	      vetorsupertop[cont]:=vetortop;	// VETORSUPERTOP RECEBE O PARAMETRO ESCOLHIDO PELO USU�RIO PARA POSTERIOR ORDENA��O	
     end;
		clrscr;       
		ordem (vetorsupertop,cont); // FUN��O QUE ORDENA DE ACORDO COM A OP��O ESCOLHIDA PELO USU�RIO NO IN�CIO DO PROGRAMA
    Writeln(' AGUARDE, ORDENANDO...');
	  delay(400);
	  clrscr;
		Writeln('POS INSC|N O M E                             |   C P F   | DAT NASC |C');

	  For i:=1 to cont do // LA�O FOR PARA ESCREVER A ORDENA��O NA TELA
	   begin
	  	vetortop := vetorsupertop[i];
	  	Seek(arq2,vetortop.pf); // POSICIONA O CURSOR NA PRIMEIRA POSI��O DE REG3.PF PARA LEITURA E ESCRITA DA ORDENA��O NA TELA DO PROGRAMA
	    Read(arq2,reg2); 
	  	Writeln(i:3,reg2.num:5,' ',reg2.nome,' ',reg2.cpf,' ',copy(reg2.data,7,2),'/',
			copy(reg2.data,5,2),'/',copy(reg2.data,1,4),' ',reg2.car);
		 end;
	   close(arq2);
	   Writeln();
		 Writeln();
		 Write('Tecle [ENTER] para encerrar.');
	   Readln;
		
End.
