Program EQ04N05; // PROGRAMA QUE ORDENA OS CANDIDATOS DE ACORDO COM AS NOTAS OBTIDAS NAS PROVAS, BEM COMO TODOS OS OUTROS CRITÉRIOS DE CLASSIFICAÇÃO, 
//ATUALIZANDO OS CAMPOS DE REG.CLG, REG2.CLC E REG2.CCL NO ARQUIVO CADAST.FIM

// ALUNOS: CLAUDINEI VARELA, DIEGO LEMOS, MATHEUS MACEDO//

uses noite;

var	  // DECLARAÇÃO DE VARIÁVEIS (GLOBAIS)
		reg2:regis; // TIPO DE REGISTRO QUE CONTÉM TODAS AS INFORMAÇÕES DE INSCRIÇÃO DE CADA CANDIDATO DO ARQUIVO CADAST.FIM
		arq2:file of regis; // VARIAVEL PARA MANUSEIO DO ARQUIVO DE CADAST.TXT
		arq3:text; // VARIAVEL PARA MANUSEIO DO ARQUIVO DE VAGAS.TXT
		nota1,nota2,nota3,nota4,soma,teste,vaga,auxvaga:string;
		data,tot,auxdata,vag,e,constante,a,a1,c:integer;
		vet,vetaux:vetor;
		dd:string[36]; // STRING QUE FUNCIONA COMO VETOR E AONDE SÃO INSERIDOS OS DADOS DE CADA CANDIDATO DE ACORDO COM O CRITÉRIO DE CLASSIFICAÇÃO DA PRÓPRIA ENLATADOS
		cargo:array[1..6] of string[28]; // VETOR QUE VAI ARMAZENAR O NOME DE CADA CARGO DE ACORDO COM SEU PRÓPRIO INDICE
		ccar:array[1..6] of integer;  //CONTADOR UTILIZADO PARA CLASSIFICAÇÃO NO CARGO
		qtdevaga:array[1..6] of integer; // VETOR QUE VAI A QTDE DE VAGAS DE CADA CARGO DE ACORDO COM SEU PRÓPRIO INDICE
		vet1:array[1..2000] of regis;
	
Begin
	assign(arq2,'CADAST.FIM');
	reset(arq2);	
		Repeat
			read(arq2,reg2);
			if (reg2.num<>0) then
		    begin
		      tot:=tot+1;
		      vet[tot].pf:=tot; //VET[TOT] RECEBE CONTADOR TOT 
		      str(reg2.so:3,soma);  //CONVERTE REG2.SO PARA STRING E ATRIBUI A CONVERSÃO PARA A VARIAVEL SOMA
		      	if (reg2.so<10) then  // SE REG2.SOMA FOR DE 1 CARACTERE, ENTÃO INSERE DOIS ZEROS A ESQUERDA
		      	insert('00',soma,1)
						else 
							if (reg2.so<100) then // SE REG2.SOMA FOR DE 1 CARACTERE, ENTÃO INSERE DOIS ZEROS A ESQUERDA
								insert('0',soma,1);//INSERE ZEROS NA FRENTE DE SOMA PARA QUE TOTALIZEM 3 NUMEROS NO STRING
		      str(reg2.n1,nota1); //CONVERTE REG2.N1 PARA STRING E ATRIBUI A CONVERSÃO PARA A VARIAVEL NOTA1
						if (reg2.n1<10) then
							insert('00',nota1,1) // SE REG2.N1 FOR DE 1 CARACTERE, ENTÃO INSERE DOIS ZEROS A ESQUERDA PARA QUE A STRING TOTALIZE 3 CARACTERES
						else 
							if (reg2.n1<100) then // SE REG2.N1 FOR DE 2 CARACTERE, ENTÃO INSERE UM ZERO A ESQUERDA PARA QUE A STRING TOTALIZE 3 CARACTERES
								insert('0',nota1,1);	
		      str(reg2.n2,nota2); //CONVERTE REG2.N2 PARA STRING E ATRIBUI A CONVERSÃO PARA A VARIAVEL NOTA12
						if (reg2.n2<10) then  // SE REG2.N2 FOR DE 1 CARACTERE, ENTÃO INSERE DOIS ZEROS A ESQUERDA PARA QUE A STRING TOTALIZE 3 CARACTERES
							insert('00',nota2,1)
						else 
							if (reg2.n2<100) then
								insert('0',nota2,1);// SE REG2.N2 FOR DE 2 CARACTERE, ENTÃO INSERE UM ZERO A ESQUERDA PARA QUE A STRING TOTALIZE 3 CARACTERES
		      str(reg2.n3,nota3); //CONVERTE REG2.N3 PARA STRING E ATRIBUI A CONVERSÃO PARA A VARIAVEL NOTA3
						if (reg2.n3<10) then
							insert('00',nota3,1) // SE REG2.N3 FOR DE 1 CARACTERE, ENTÃO INSERE DOIS ZEROS A ESQUERDA PARA QUE A STRING TOTALIZE 3 CARACTERES
						else 
							if (reg2.n3<100) then
								insert('0',nota3,1); // SE REG2.N3 FOR DE 2 CARACTERE, ENTÃO INSERE UM ZERO A ESQUERDA PARA QUE A STRING TOTALIZE 3 CARACTERES
		      str(reg2.n4,nota4);  //CONVERTE REG2.N3 PARA STRING E ATRIBUI A CONVERSÃO PARA A VARIAVEL NOTA4
						if (reg2.n4<10) then
							insert('00',nota4,1) // SE REG2.N4 FOR DE 1 CARACTERE, ENTÃO INSERE DOIS ZEROS A ESQUERDA PARA QUE A STRING TOTALIZE 3 CARACTERES
						else 
							if (reg2.n4<100) then   // SE REG2.N3 FOR DE 2 CARACTERE, ENTÃO INSERE UM ZERO A ESQUERDA PARA QUE A STRING TOTALIZE 3 CARACTERES
								insert('0',nota4,1);	
		      constante:=20171111;            // CONSTANTE QUE REALIZA A SUBTRAÇÃO COM A STRING DE DATA PARA CLASSIFICAR OS CANDIDATOS PELA IDADE (DA MAIOR PARA MENOR)
		      teste:=reg2.data;
		      val(reg2.data,auxdata,e);      //CONVERTE REG2.DATA PARA INTEIRO E ATRIBUI A CONVERSÃO PARA A VARIAVEL AUXDATA
		      data:=constante-auxdata;		  //VARIAVEL QUE RECEBE O RESULTADO DA SUBTRAÇÃO 
		      str(data,dd);                 //CONVERTE O RESULTADO DA VARIAVEL DATA, PARA STRING
		      Insert(soma,dd,1);            
		      Insert(nota3,dd,4);            // INSERE AS INFORMAÇÕES EM ORDEM DE CRITÉRIO DE DESEMPATE NA STRING DD[36]
		      Insert(nota4,dd,7);          
		      Insert(nota2,dd,10);
		      Insert(nota1,dd,13);
		      vet[tot].c_chave:=dd;        //VET.C-CHAVE RECEBE TODO O CONTEUDO DA STRING DD
		    end;
		until(eof(arq2));
		
		ordem(vet,tot); //ORDENA A CLASSIFICAÇÃO ATRÁVES DO VETOR COM AS INFORMAÇÕES QUE CONTÉM OS CRITÉRIOS DE CLASSIFICAÇÃO
		assign(arq3,'VAGAS.TXT');  // ABRE ARQUIVO VAGAS.TXT
		reset(arq3); // POSICIONA O CURSOR NO INÍCIO DO ARQUIVO VAGAS.TXT 
		
		for a:=1 to 6 do //LÊ A QUANTIDADE DE VAGAS POR CARGO
			begin
				read(arq3,vaga);                            
				auxvaga:=copy(vaga,30,2); // RECEBE O NOME DO CARGO                  
				val(auxvaga,vag,e);
				auxvaga:=copy(vaga,2,28);  // RECEBE A QUANTIDADE DE VAGAS NO CARGO
				cargo[a]:=auxvaga;    //VETOR CARGO RECEBE O NOME DO CARGO
				qtdevaga[a]:=vag;     // VETOR QTDEVAGA RECEBE A QTDE DE VAGAS POR CARGO
			end;
		reset(arq2); // POSICIONA O CURSOR NO INICIO DE CADAST.FIM
		c:=1;
			for a:=tot downto 1 do  // ORDENA O VETOR DE TRÁS PARA FRENTE E ATUALIZA O CAMPO REG2.CLG NO CADAST.FIM
				begin					
					seek(arq2,vet[a].pf-1);   //REPOSICIONA O VETOR
					read(arq2,reg2);					
					reg2.clg:=c;	     //CLASSIFICAÇÃO GERAL VAI SER DADA PELO CONTADOR, C
					seek(arq2,vet[a].pf-1); // BUSCA E GRAVA EM CADAST.FIM
					write(arq2,reg2);
					c:=c+1;  //PREPARA O CONTADOR PARA O PRÓXIMO CLASSIFICADO
			  end;
		close(arq2);	  
		reset(arq2);
			for a:=tot downto 1 do
				begin
					seek(arq2,vet[a].pf-1);
					read(arq2,reg2);	
						if  qtdevaga[reg2.car]<>0 then  //SE HOUVER VAGA
						begin	
			        reg2.ccl:=reg2.car;  // CARGO CLASSIFICADO RECEBE CARGO
			        qtdevaga[reg2.car]:=qtdevaga[reg2.car]-1;   //ATUALIZA O CAMPOS DE VAGAS REMANESCENTES
		        end;
						ccar[reg2.car]:= ccar[reg2.car]+1;            //CONTADOR PARA CLASSIFICAÇÃO NO CARGO
						reg2.clc:=ccar[reg2.car];                     
		      seek(arq2,vet[a].pf-1);       // REPOSICIONA E GRAVA EM CADAST.FIM
					write(arq2,reg2);
			  end;	  
	close(arq2);
	close(arq3);
End.