Program EQ04N06;

//ALUNOS: CLAUDINEI VARELA, DIEGO LEMOS, MATHEUS DE MACEDO

uses noite;

var reg2:regis; // TIPO DE REGISTRO QUE CONTÉM TODAS AS INFORMAÇÕES DE INSCRIÇÃO DE CADA CANDIDATO DO ARQUIVO CADAST.FIM
arq2:file of regis; // VARIAVEL PARA MANUSEIO DO ARQUIVO DE CADAST.TXT
w,g,t,b,c,e:integer;
vetorsupertop:vetor; // VETOR QUE RECEBE OS PARAMETROS NECESSÁRIOS PARA REALIZAR A ORDENAÇÃO DE ACORDO COM A ESCOLHA DO USUÁRIO 
vetortop:cc;
ne,nc:string[1];
so,clcaux:string[4];
classi:string[30]; // VARIAVEL UTILIZADA PARA ESCREVER CLASSIFICADO SOMENTE PARA OS CANDIDATOS APROVADOS
trabalho:array[1..6] of String; // VETOR QUE VAI ARMAZENAR O NOME DE CADA CARGO DE ACORDO COM SEU PRÓPRIO INDICE
  
Begin
	repeat
		Writeln('SELECIONE UMA DAS OPCÕES A SEGUIR:');
  	writeln('[1] - CLASSIFICAÇÃO DOS CARGOS EM ORDEM ALFABÉTICA');
 		writeln('[2] - CLASSIFICAÇÃO POR CARGO');
 		writeln('[3] - CLASSIFICAÇÃO GERAL');
  	readln(ne);
  	val(ne,b,e);   //LE A OPCAO ESCOLHIDA EM STRING E CONVERTE PRA INTEIRO
  until(b>0)and(b<4)and(e=0);                      
	while (w<>3) and (c<>6) do  //LOOP DO PROGRAMA, REPETE TUDO ATÉ QUE W=3(AUX PARA OPCÇÃO 3) E C=6 (TODOS OS CARGOS MOSTRADOS)                     
	begin		                                         
		c:=c+1;  	                                     //CONTADOR CARGO, A CADA LOOP (OPCAO 1 E 2)  PEGA O PROXIMO CARGO E REFAZ TUDO.
  //Passa a opção escolhida para vetortop.nome.
  
	Assign(arq2,'CADAST.FIM'); // ABRE ARQUIVO CADAST.FIM
	Reset(arq2); // POSICIONA O CURSOR NO INÍCIO DO ARQUIVO CADAST.FIM   
	While not eof (arq2) do  // ENQUANTO NÃO CHEGAR ATÉ O FINAL DE CADAST.FIM
		begin
		 	Read(arq2,reg2);
				if (b=1) then  // SE OPÇÃO DE ORDENAÇÃO FOR POR CARGOS E ORDEM ALFABÉTICA
					begin                             
				    if (reg2.ccl=c) then  //SE REG2.CCL FOR IGUAL AO CARGO PRETENDIDO (classificação cargo)
			  			begin
								vetortop.pf:=g;                           //VETORTOP.PF RECEBE POSIÇÃO FISICA G 
								vetortop.c_chave:=reg2.nome;              //VETORTOP.C_CHAVE RECEBE NOME DOS CANDIDATOS 
								e := e +1;	
								vetorsupertop[e]:=vetortop;	// VETORSUPERTOP RECEBE NOME DOS CANDIDATOS APROVADOS NO CARGO E OS ORDENA	                    	           
							end;					        	
		      end;

			  if (b=2) then  //OPCAO 2 ( CLASSIFICAÇÃO POR CARGO)
			  	begin
			  		if (reg2.car=c) then  //SE REG2.CARGO FOR IGUAL AO CARGO DO CONTADOR
			  			begin			  			
			  				vetortop.pf:=g; //VETORTOP.PF RECEBE POSIÇÃO FISICA G 
			  				str (reg2.clc:4,clcaux) ; //CONVERTE REG2.CLC PRA STRING QUE VAI PARA A VARIÁVEL CLCAUX
			  					if (length(clcaux)<4) then
			  						begin
			  							insert('0',clcaux,1);//COMPLETA COM ZEROS EX = CLC 1 = 0001
	  				    		end;
										vetortop.C_CHAVE:=clcaux; // VETORTOP RECEBE O CONTEÚDO DE REG2.CLC 
										e := e +1; 
										vetorsupertop[e]:=vetortop;	// VETORSUPERTOP RECEBE O CONTEÚDO DE REG2.CLC 	                      
							end;									
		    	end;
		 
				if (b=3) then
			    begin
			      vetortop.pf:=e; //RECEBE POSIÇÃO FISICA E = QUE CONTA TODAS AS POSIÇOES
			      str(reg2.clg,so); //CONVERTE REG2.CLG PRA STRING E ATRIBUI PARA A VARIÁVEL SO
			       repeat
	  					insert('0',so,1);
	  				 until(length(so)=4); //INSERE ZEROS ATÉ QUE A QTDE DE CARACTERES SEJA IGUAL A 4
			        vetortop.C_CHAVE:=so;   // VETORTOP RECEBE O CONTEÚDO DE REG2.CLG 
							e := e +1;	
							vetorsupertop[e]:=vetortop; // VETORSUPERTOP RECEBE O CONTEÚDO DE REG2.CLG 		
		 			end;	
				g:=g+1;	 // VARIAVEL QUE CONTÉM A POSIÇÃO FÍSICA DE OPÇÃO 1 E 2 
  	
    end;
		clrscr;       
		Writeln('AGUARDE, ORDENANDO...');
		ordem (vetorsupertop,e); // AQUI ORDENA TUDO, APARTIR DO CONTADOR DE TODAS AS POSIÇÕES
		clrscr;

		if (b=1) or (b=2) then
		begin
		trabalho[1]:= 'ARQUITETO';
		trabalho[2]:= 'ENGENHEIRO ELÉTRICO';
		trabalho[3]:= 'ENGENHEIRO CIVIL';
		trabalho[4]:= 'ANALISTA DE SISTEMAS';
		trabalho[5]:= 'ENGENHEIRO MECÂNICO';
		trabalho[6]:= 'TÉCNICO EM REDES';
	
		writeln ('CURSO:  ',c:-3,trabalho[c]:5); //SE OPCAO 1 OU 2, MOSTRA TODOS OS CURSOS
		writeln;
		end
		 else
			begin
			 writeln('CLASSIFICAÇÃO GERAL DOS CANDIDATOS');
			 writeln;
			end;
       if (b=1) then  //CABEÇALHO DA OPCAO 1
				begin
					writeln('ORD NUM  N O M E                              NASCIMENTO CAR');
				end
				else    //CABEÇALHO DAS OPÇOES 2 E 3
					begin
 						writeln('ORD  NUM N O M E                              ===C P F=== NASCIMENTO CS  N1  N2  N3  N4  SO  CG  CC  CV   OBSERVAÇÃO');
				  end;

				for t:=1 to e do                                              //LAÇO PARA ESCREVER OS RESULTADOS
					begin
						vetortop:=vetorsupertop[t];
						seek(arq2,vetortop.pf);
	  				read(arq2,reg2);
	  				CLASSI:='';           // ESCREVE CLASSIFICADO PARA OPÇÕES 2 E 3 
	  					if (b<>1) and (reg2.ccl<>0) then
								begin
									CLASSI:=('CLASSIFICADO')                                                  
								end;
 
 						if (b=1) then    //SE OPCAO FOR 1, ESCREVE NA TELA
							begin
								writeln(t:3,reg2.num:5,' ',reg2.nome,' ',copy(reg2.data,7,2),'/',copy(reg2.data,5,2),'/',copy(reg2.data,1,4),reg2.car:3,'  ',CLASSI);
							end
							else  //SENAO NAO FOR 1, ESCREVE 
								begin
 									writeln(t:3,reg2.num:5,' ',reg2.nome,' ',reg2.cpf,' ',copy(reg2.data,7,2),'/',
										copy(reg2.data,5,2),'/',copy(reg2.data,1,4),reg2.car:3,reg2.n1:4,reg2.n2:4,
										reg2.n3:4,reg2.n4:4,reg2.so:4,reg2.clg:4,reg2.clc:4,reg2.ccl:4,'  ',CLASSI);
					end;			
						end;
				close(arq2);
				if (c>0) and (c<6) and (b<3) then   //SE O CARGO FOR DE 1 A 6 E DE OPCAO 1 OU 2...
					begin
						writeln(); 
						writeln('TECLE [ENTER] PARA CONTINUAR');
						readkey; 
				  end
				  	else
					  if (c=6) or (b=3) then  //SE CARGO ATINGIR 6 OU OPÇAO 3 FOR ESCOLHIDA...
					   begin
						  writeln(); 
						  writeln('TECLE [ENTER] PARA ENCERRAR');
						  readkey;
					   end;                 
		  		e:=0;
					g:=0;  // CONTADORES RESETAM  PARA SE PREPARAR PRO PRÓXIMO POSSIVEL LOOP
					t:=0;
								                                              
				if (b=3) then  // SE OPÇÃO ESCOLHIDA FOR 3, O PROGRAMA NÃO REPETE.
					begin
						w:=3;
					end;
					end;	  	         
End.