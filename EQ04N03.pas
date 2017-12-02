Program EQ04N03;  // PROGRAMA QUE ABRE O ARQUIVO CADAST.FIM E PERMITE O USUÁRIO ORDENAR OS CANDIDATOS POR: INSCRIÇÃO, NOME,CPF E DATA

// ALUNOS: CLAUDINEI VARELA, DIEGO LEMOS, MATHEUS MACEDO//

uses crt,NOITE;

var
numaux:string[4];
opcao:string[1]; // VÁRIAVEL QUE RECEBE OPÇÃO DE ORDENAÇÃO ESCOLHIDA PEÇO CANDIDATO
reg2:regis; // TIPO DE REGISTRO QUE CONTÉM TODAS AS INFORMAÇÕES DE INSCRIÇÃO DE CADA CANDIDATO
arq2:file of regis; // VARIAVEL PARA MANIPULAÇÃO DE CADAST.FIM
opcaoaux,a,i,e,cont:Integer;
vetortop:cc;  // VETOR QUE CONTÉM OS CAMPOS .PF E .C_CHAVE                
vetorsupertop:vetor;  // VETOR QUE RECEBE O CONTEÚDO DE REG3.C_CHAVE E É UTILIZADO COMO PARAMETRO PARA ORDENAÇÃO DA FUNÇÃO ORDEM DA UNIT NOITE        

begin
repeat
	Writeln(' Escolha uma opção de ordenação.');
	Writeln(' [1] Ordenação por INSCRIÇÃO.');
	Writeln(' [2] Ordenação por NOME.');
	Writeln(' [3] Ordenação por CPF.');
	Writeln(' [4] Ordenação por DATA.');
	readln (opcao);  // VÁRIAVEL QUE RECEBE OPÇÃO DE ORDENAÇÃO ESCOLHIDA PEÇO CANDIDATO.
	val(opcao,opcaoaux,e); // CONVERTE OPÇÃO(STRING) PARA OPCAOAUX(INTEIRO) PARA QUE SEJAM FEITAS AS VALIDAÇÕES
	 If (opcaoaux >4) or (opcaoaux <1)  then
		begin
			Writeln('Opção INVÁLIDA. Digite um número [1 a 4]');
			e:=1;
			clrscr;
		end;
Until (opcaoaux>0) and (opcaoaux <5) and (e=0);  // REPETE O ÍNICIO DO PROGRAMA ATÉ QUE A OPÇÃOAUX SEJA UM VALOR ENTRE 1 E 4

	Assign(arq2,'CADAST.FIM');  // ABRE ARQUIVO CADAST.FIM
	Reset(arq2); // POSICIONA O CURSOR NO INÍCIO DO ARQUIVO CADAST.FIM 
	 While not eof (arq2) do  // ENQUANTO NÃO CHEGAR ATÉ O FINAL DE CADAST.FIM
		 begin
		 	Read(arq2,reg2);  // LÊ REG2( STRING DE 60) QUE CONTÉM TODAS AS INFORMAÇÕES DE CADA CANDIDATO 
		 	vetortop.pf:=cont;
				if (opcaoaux=1) then  //SE OPÇAO ESCOLHIDA FOR IGUAL A 1 ,VETORTOP.C_CHAVE RECEBE NÚMERO DE INSCRIÇÃO DO CANDIDATO
					begin
					 str (reg2.num:4,numaux); // CONVERTE NÚMERO DE INSCRIÇÃO DO CANDIDATO PARA STRING
					 vetortop.C_CHAVE:=numaux; 	
		      end;
			    if (opcaoaux=2) then //SE OPÇAO ESCOLHIDA FOR IGUAL A 2 , VETORTOP.C_CHAVE RECEBE NOME DO CANDIDATO
			     begin
				 	   vetortop.C_CHAVE:=reg2.nome;		
		       end;
					  if (opcaoaux=3) then //SE OPÇAO ESCOLHIDA FOR IGUAL A 3, VETORTOP.C_CHAVE RECEBE NÚMERO DE CPF DO CANDIDATO
			       begin
			        vetortop.C_CHAVE:=reg2.cpf;	
		 				 end;
						  if (opcaoaux=4) then //SE OPÇAO ESCOLHIDA FOR IGUAL A 4 , VETORTOP.C_CHAVE RECEBE DATA DE NASCIMENTO (ANO/MÊS/DIA) DO CANDIDATO
		           begin
							  vetortop.C_CHAVE:=reg2.data;
						   end;
										 
        cont := cont +1;
	      vetorsupertop[cont]:=vetortop;	// VETORSUPERTOP RECEBE O PARAMETRO ESCOLHIDO PELO USUÁRIO PARA POSTERIOR ORDENAÇÃO	
     end;
		clrscr;       
		ordem (vetorsupertop,cont); // FUNÇÃO QUE ORDENA DE ACORDO COM A OPÇÃO ESCOLHIDA PELO USUÁRIO NO INÍCIO DO PROGRAMA
    Writeln(' AGUARDE, ORDENANDO...');
	  delay(400);
	  clrscr;
		Writeln('POS INSC|N O M E                             |   C P F   | DAT NASC |C');

	  For i:=1 to cont do // LAÇO FOR PARA ESCREVER A ORDENAÇÃO NA TELA
	   begin
	  	vetortop := vetorsupertop[i];
	  	Seek(arq2,vetortop.pf); // POSICIONA O CURSOR NA PRIMEIRA POSIÇÃO DE REG3.PF PARA LEITURA E ESCRITA DA ORDENAÇÃO NA TELA DO PROGRAMA
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
