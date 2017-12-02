Program EQ04N04 ; // PROGRAMA QUE RECEBE O GABARITO DA PROVA 1 E 2 , ABRE O ARQUIVO DA RESPECTIVA PROVA,COMPARA COM O GABARITO DOS ALUNOS E ATRIBUI NOTAS AOS CANDIDATOS E ATUALIZA O CAMPO NOTAS O CADAST.FIM

// ALUNOS: CLAUDINEI VARELA, DIEGO LEMOS, MATHEUS MACEDO//

uses noite;
var  // DECLARAÇÃO DE VARIÁVEIS (GLOBAIS)
	ne:string[1];
	cont,pag,b,e,a1,n,qc,qb,od,c,aux,n1,auxb,a,m1,m2:integer;
	arq:text; // VARIAVEL PARA MANUSEIO DO ARQUIVO DE PROVAS.TXT
	arq2:file of regis;  // VARIAVEL PARA MANUSEIO DO ARQUIVO DE CADAST.TXT
	gaba:string[50]; // VARIAVEL QUE RECEBE GABARITO( DA PROVA ESCOLHIDA) E QUE É INSERIDA PELO PRÓPRIO USUÁRIO)
	vn:boolean;
	prova:string[54];// STRING DO ARQUIVO PROVA QUE CONTÉM A RESPOSTA DO GABARITO DOS CANDIDATOS
	num:string[4];
	reg2:regis; // TIPO DE REGISTRO QUE CONTÉM TODAS AS INFORMAÇÕES DE INSCRIÇÃO DE CADA CANDIDATO DO ARQUIVO CADAST.FIM
	vetorsupertop:vetor; // VETOR QUE RECEBE O CONTEÚDO DE REG2.NUM E É UTILIZADO COMO PARAMETRO PARA ORDENAÇÃO DA FUNÇÃO ORDEM DA UNIT NOITE
	
PROCEDURE CABECA;
BEGIN
 CLRSCR ;
 PAG:=PAG+1;
 WRITELN('                         RELATORIO CORREÇÃO - ORDEM INSCRIÇÃO                         PAGINA:',PAG:3);
 WRITELN;
 if(b=1)then // SE PROVA ESCOLHIDA PARA CORREÇÃO FOR IGUAL A 1 
 writeln('                                             PORTUGUES    MATEMATICA')
 else // SE PROVA ESCOLHIDA PARA CORREÇÃO FOR IGUAL A 2 
 writeln('                                            ESPECIFICO    INFORMATICA');
 writeln;
 writeln(' NUM N O M E                               CE  ER BR NOT  CE  ER BR NOT');
END;

Begin
	repeat   //OFERECE OPÇÕES DE CORREÇÃO.//
  	write('Qual prova deseja corrigir? 1 ou 2: ');
  	read(ne);
  	val(ne,b,e);
	until(b>=1)and(b<=2)and(e=0); // VALIDA SOMENTE OPÇÃO DE PROVA FOR IGUAL A 1, OU IGUAL A 2
		if(b=1)then // SE PROVA ESCOLHIDA PARA CORREÇÃO FOR IGUAL A 1
			assign(arq,'prova1.txt') // ABRE PROVA1.TXT
			else if(b=2)then
				assign(arq,'prova2.txt');  // SENÃO ABRE PROVA2.TXT
				reset(arq);

	repeat //VALIDAÇÃO DO GABARITO.//  
		write('Digite o gabarito: ');
		read(gaba); //VARIAVEL QUE RECEBE GABARITO (DA PROVA ESCOLHIDA)
		gaba:=upcase(gaba);
		vn:=true;
			for a1:=1 to length(gaba)do // DA PRIMEIRA LETRA DO GABARITO ATÉ A ÚLTIMA
				if not(gaba[a1] in ['A'..'E'])then
					begin
						vn:=false;
					end;
					if not(vn)then
						Writeln('Inválido, tente novamente.'); // SE A STRING DO GABARITO RECEBER ALGUM CARACTERE DIFERENTE DE A ATÉ E, O PROGRAMA INVÁLIDA O GABARITO
	until(vn);
	clrscr;
	CABECA;

//ORDENA CADAST.FIM POR NÚMERO DE INSCRIÇÃO  
begin
	Assign(arq2,'CADAST.FIM'); // ABRE ARQUIVO CADAST.FIM
	Reset(arq2); // POSICIONA O CURSOR NO INÍCIO DO ARQUIVO CADAST.FIM  
		While not eof (arq2) do // ENQUANTO NÃO CHEGAR ATÉ O FINAL DE CADAST.FIM
		 begin
		 	Read(arq2,reg2);
		 	vetorsupertop[cont+1].pf:=cont;
			str (reg2.num:4,vetorsupertop[cont+1].C_CHAVE);// CONVERTE PARA STRING O NÚMERO DE INSCRIÇÃO DO CANDIDATO E INSERE EM  VETORSUPERTOP.C_CHAVE	 									 
  		cont := cont +1;	// CONTADOR 
 		 end;     
	ordem (vetorsupertop,cont); // ORDENA OS CANDIDATOS PELO NÚMERO DE INSCRIÇÃO 
	Readln(arq2,reg2);

//EXTRAI AS RESPOSTAS//
	repeat // REPETE PROCESSO A SEGUIR ATÉ CHEGAR NO FIM DO ARQUIVO DE PROVA.TXT
		begin
			readln(arq,prova); // ABRE ARQUIVO PROVA.TXT
			num:=copy(prova,1,4); // COPIA OS 4 PRIMEIROS CARACTERES DE PROVA.TXT QUE REFERE-SE AO NÚMERO DE INSCRIÇÃO DO CANDIDATO
			if num[1]='0' then // SEÇÃO DE IF'S QUE INSERE ZEROS A ESQUERDA ATÉ QUE NÚMERO DE INSCRIÇÃO SEJA IGUAL A 4.
				begin
					num[1]:=' ';
			  	if num[2]='0' then
			  		begin
		        	num[2]:=' ';
		        		if num[3]='0' then
		        			num[3]:=' ';
		        end;
		  	end; 

			a1:=1;
			qc:=0; // VÁRIAVEL QUE RECEBE O NÚMERO DE INSCRIÇÕES CERTAS
			qb:=0; // VÁRIAVEL QUE RECEBE O NÚMERO DE INSCRIÇÕES EM BRANCO
			od:=od+1;
			for c:=1 to 2 do
				begin 
					if(c=2)then // SE A PROVA CORRIGIDA FOR A 2
						begin
							aux:=n1; // AUX RECEBE A NOTA DA PRIMEIRA MATÉRIA
							auxb:=qb; // AUXB RECEBE A QTDE DE NOTAS BRANCAS DA PRIMEIRA MATÉRIA
							a1:=26;
							qb:=0; // QUANTIDADE DE QUESTÕES BRANCAS RECEBE ZERO
							qc:=0;  // QUANTIDADE DE QUESTÕES CERTAS RECEBE ZERO
						end;
						
// CORRIGE A PROVA DESEJADA.//

		for a:=a1 to a1+24 do
			begin
				if(prova[a+4]=' ')then // SE A STRING DE PROVA.TXT TIVER ALGUMA RESPOSTA EM BRANCA, QB RECEBE QB=1
					qb:=qb+1; 
					if(prova[a+4]=gaba[a])then // SE O CARACTERE DA STRING PROVA DO ARQUIVO PROVA.TXT FOR IGUAL AO CARACTERE NA MESMA POSIÇÃO DO GABARITO INSERIDO
					qc:=qc+1; //QC RECEBE QB=1
			end;
			n1:=qc*4; // CALCULA A NOTA DA PROVA, MULTIPLICANDO QUESTÕES CERTAS POR 4
end;
	pebin1(vetorsupertop,num,cont,c); // FUNÇÃO QUE REALIXA PESQUISA BINÁRIA
  if (c>0) then
   	begin
   		seek (arq2, vetorsupertop[c].pf); // POSICIONA O CURSOR NA PRIMEIRA POSIÇÃO FISÍCA DO ARQUIVO
			read(arq2,reg2);
		 	if(b=1)then // SE PROVA ESCOLHIDA FOR IGUAL A 1
				begin	 //
					reg2.n1:=aux;
					reg2.n2:=n1;
					reg2.so:=aux+n1+reg2.n3+reg2.n4;	
				end
				else
					begin
						reg2.n3:=aux;
						reg2.n4:=n1;
						reg2.so:=reg2.n1+reg2.n2+aux+n1;
					end;
	
			m1:=m1+aux; // VARIAVEL QUE RECEBE AS SOMAS DAS NOTAS DA PRIMEIRA MATÉRIA DA PROVA CORRIGIDA DE TODOS OS CANDIDATOS, PARA CALCULAR A MÉDIA AO FINAL DO PROGRAMA
			m2:=m2+n1;  // VARIAVEL QUE RECEBE AS SOMAS DAS NOTAS DA SEGUNDA MATÉRIA DA PROVA CORRIGIDA DE TODOS OS CANDIDATOS, PARA CALCULAR A MÉDIA AO FINAL DO PROGRAMA
			writeln(reg2.num:4,reg2.nome:37,aux div 4:4,50-(aux div 4):4,auxb:3,aux:4,n1 div 4:4,50-(n1 div 4):4,qb:3,n1:4);
			seek(arq2,vetorsupertop[c].pf);
			write(arq2,reg2); // GRAVA OS CAMPOS N1,N2,SO ( E N3 E N4 QUANDO FOR O CASO) EM CADAST.FIM
			
	if(od mod 50 =0)then // VAI MOSTRAR O RESULTADO DE 50 EM 50 LINHAS, PARA CONTINUAR MOSTRANDO O USUÁRIO PRECISA CLICAR EM ENTER
		begin
			readkey;
			CABECA;
		end;		
end;
end;
until eof  (arq); 	
close(arq);
close(arq2);
writeln;
writeln;
writeln('ENTER PARA LIMPAR E MOSTRAR MÉDIAS...');
readkey;
clrscr;
WRITELN('                          RELATORIO CORREÇÃO - MÉDIAS                                  PAGINA:',PAG+1:3);
writeln;
writeln;
if(b=1)then  // SE A PROVA CORRIGIDA FOR A 1
begin
writeln('PORTUGUES  ===:',m1/od); // SOMA DA NOTA DE PORTUGUÊS DE TODOS OS CANDIDATOS DIVIDIDO PELA QUANTIDADE DE CANDIDATOS
writeln;
writeln('MATEMATICA ===:',m2/od);  // SOMA DA NOTA DA NOTA DE MATEMÁTICA  DE TODOS OS CANDIDATOS DIVIDIDO PELA QUANTIDADE DE CANDIDATOS
writeln;
end
else   // SE A PROVA CORRIGIDA FOR A 2
begin
writeln('ESPECIFICO  ===:',m1/od); // SOMA DA NOTA DA NOTA DE ESPECÍFICAS DE TODOS OS CANDIDATOS DIVIDIDO PELA QUANTIDADE DE CANDIDATOS
writeln;
writeln('INFORMATICA ===:',m2/od); // SOMA DA NOTA DA NOTA DE INFORMÁTICA DE TODOS OS CANDIDATOS DIVIDIDO PELA QUANTIDADE DE CANDIDATOS
end;
writeln;
writeln('Enter para encerrar...');
readkey;

end;  
End.