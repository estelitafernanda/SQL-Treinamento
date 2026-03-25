ALTER FUNCTION dbo.fn_Rev_Consulta_902 (
	@idTransacao INT,
	@CodigoRetorno INT
)
RETURNS @Transacao TABLE 
(
	 inParteFixa VARCHAR(37),
	 inPlaca VARCHAR(7),
	 outParteFixa VARCHAR(37),
	 outCodigoRetorno INT,
	 outMensagemErro VARCHAR(255),
	 outCodigoIdentificacaoVeiculo VARCHAR(21),
	 outPlacaUnica VARCHAR(7),
	 outCodigoRenavam INT,
	 outNomeSituacaoVeiculo VARCHAR(10),
	 outCodigoMunicipioEmplacamento INT,
	 outUfJurisdicao VARCHAR(2),
	 outTipoRemarChassi INT,
	 outNomeTipoMontagem VARCHAR(13),
	 outCodigoTipoVeiculo INT,
	 outCodigoMarcaModelo INT,
	 outCodigoEspecieVeiculo INT,
	 outCodigoTipoCarroceria INT,
	 outCodigoCor INT,
	 outAnoModelo INT,
	 outAnoFabricacao INT,
	 outPotenciaVeiculo INT,
	 outCilindradas INT,
	 outCodigoCombustivel INT,
	 outNumeroMotor VARCHAR(21),
	 outCMTVeiculo DECIMAL(5, 2),
	 outPBTVeiculo DECIMAL(5, 2),
	 outCapacidadeCarga DECIMAL(5,2),
	 outNomeProcedenVeiculo VARCHAR(11),
	 outNumeroCaixaCambio VARCHAR(21),
	 outTipoDocumentoProprietario INT,
	 outNumeroIdentificaProprietario VARCHAR(14), 
	 outNumeroCarroceria VARCHAR(21),
	 outCapacidadePassageiros INT,
	 outCodigoRestricao1 INT,
	 outCodigoRestricao2 INT,
	 outCodigoRestricao3 INT,
	 outCodigoRestricao4 INT,
	 outNumeroEixos INT,
	 outNumeroEixoTraseiro VARCHAR(21),
	 outNumeroEixoAuxiliar VARCHAR(21),
	 outTipoDocumentoImportador INT,
	 outNumeroIdentifiImportador VARCHAR(14),
	 outCodigoOrgaoRfb INT, 
	 outNumeroReda INT,
	 outNumeroDi INT,
	 outDataRegistroDi INT,
	 outTipoDocumentoFaturado INT,
	 outNumeroIdentificacaoFaturado VARCHAR(14),
	 outUfDestinoFaturamento VARCHAR(2),
	 outDataLimiteRestricaoTributa INT,
	 outDataUltimaAtualizacao INT,
	 outTipoOperacaoImportacaoVeiculo INT, 
	 outNumeroProcessoImportacao INT,
	 outDataBaixaTransfOutroPais INT,
	 outCodigoPaisTransf VARCHAR(5),
	 outIndicadorMultaExigivelRenainf INT,
	 outIndicadorComunicaVenda INT,
	 outIndicadorPendenciaEmissao INT,
	 outIndicadorRestricaoRenajud INT,
	 outIndicadorOcorrenciaRecall1 INT,
	 outIndicadorOcorrenciaRecall2 INT,
	 outIndicadorOcorrenciaRecall3 INT,
	 outIndicadorRecallMontadora INT,
	 outCodigoCategoriaVeiculoMre INT,
	 outTipoDocProprietarioIndicado INT,
	 outNumeroDocProprietarioIndicado VARCHAR(14),
	 outDataUltimaAtualizacaoMre INT,
	 outIndicadorEmplacamentoEletronico INT,
	 outOrigemIndicacaoPropriedade INT,
	 outIndicadorRestricaoRfb INT,
	 outIndicadorPlacaVeicular INT,
	 outIndicadorRestricoes INT
) AS BEGIN

	DECLARE @MensagemErro VARCHAR(255), @MensagemEnvio VARCHAR(44), @MensagemRetorno VARCHAR(450)

	SET @MensagemErro = dbo.fn_Mensagem(@CodigoRetorno)

	SET @MensagemEnvio = (
		SELECT
			MensagemEnvio
		FROM Efab_Transacao
		WHERE idTransacao = @idTransacao
	)
	SET @MensagemRetorno = (
		SELECT
			MensagemRetorno

		FROM Efab_Transacao
		WHERE idTransacao = @idTransacao
	)
	 
		 
		RETURN INSERT INTO @Transacao
		SELECT 
			SUBSTRING(@MensagemEnvio, 1, 37), --ParteFixaIN
			SUBSTRING(@MensagemEnvio, 38, 7), --PlacaIN
			SUBSTRING(@MensagemRetorno, 1, 37), --ParteFixaOUT
			SUBSTRING(@MensagemRetorno, 38, 3), --CodigoRetornoOUT
			@MensagemErro, --MensagemErro
			SUBSTRING(@MensagemRetorno, 41, 21), --CodigoIdentificacao
			SUBSTRING(@MensagemRetorno, 62, 7), --PlacaUnica
			SUBSTRING(@MensagemRetorno, 69, 11), --CodigoRenavam
			SUBSTRING(@MensagemRetorno, 80, 10), --NomeSituacaoVeiculo
			SUBSTRING(@MensagemRetorno, 90, 4), --CodigoMunicipioEmplacamento
			SUBSTRING(@MensagemRetorno, 94, 2), --UfJurisdicao
			SUBSTRING(@MensagemRetorno, 96, 1), --TipoRemarcacaoChassi
			SUBSTRING(@MensagemRetorno, 97, 13), --nome-tipo-montagem
			SUBSTRING(@MensagemRetorno, 110, 2), --código-tipo-veículo
			SUBSTRING(@MensagemRetorno, 112, 6), --código-marca-modelo
			SUBSTRING(@MensagemRetorno, 118, 1), --código-espécie-veículo
			SUBSTRING(@MensagemRetorno, 119, 3), --código-tipo-carroceria
			SUBSTRING(@MensagemRetorno, 122, 2), --código-cor
			SUBSTRING(@MensagemRetorno, 124, 4), --ano-modelo
			SUBSTRING(@MensagemRetorno, 128, 4), --ano-fabricação
			SUBSTRING(@MensagemRetorno, 132, 3), --potência-veículo
			SUBSTRING(@MensagemRetorno, 135, 4), --cilindradas
			SUBSTRING(@MensagemRetorno, 139, 2), --código-combustível
			SUBSTRING(@MensagemRetorno, 141, 21), --número-motor
			SUBSTRING(@MensagemRetorno, 162, 5), --CMT-veículo
			SUBSTRING(@MensagemRetorno, 167, 5), --PBT-veículo
			SUBSTRING(@MensagemRetorno, 172, 5), --capacidade-carga
			SUBSTRING(@MensagemRetorno, 177, 11), --nome-procedência-veículo
			SUBSTRING(@MensagemRetorno, 188, 21), -- número-caixa-câmbio
			SUBSTRING(@MensagemRetorno, 209, 1), -- tipo-documento-proprietário
			SUBSTRING(@MensagemRetorno, 210, 14), --número-identificação-proprietário
			SUBSTRING(@MensagemRetorno, 224, 21), --número-carroceria
			SUBSTRING(@MensagemRetorno, 245, 3), --capacidade-passageiros
			SUBSTRING(@MensagemRetorno, 248, 2), --código-restrição-1
			SUBSTRING(@MensagemRetorno, 250, 2), --código-restrição-2
			SUBSTRING(@MensagemRetorno, 252, 2), --código-restrição-3
			SUBSTRING(@MensagemRetorno, 254, 2), --código-restrição-4
			SUBSTRING(@MensagemRetorno, 256, 2), --número-eixos
			SUBSTRING(@MensagemRetorno, 258, 21), --número-eixo-traseiro
			SUBSTRING(@MensagemRetorno, 279, 21), --número-eixo-auxiliar
			SUBSTRING(@MensagemRetorno, 300, 1), --tipo-documento-importador
			SUBSTRING(@MensagemRetorno, 301, 14), --número-identificação-importador
			SUBSTRING(@MensagemRetorno, 315, 7), --código-órgão-RFB
			SUBSTRING(@MensagemRetorno, 322, 5), --número-REDA
			SUBSTRING(@MensagemRetorno, 327, 10), --número-DI
			SUBSTRING(@MensagemRetorno, 337, 8), --data-registro-DI
			SUBSTRING(@MensagemRetorno, 345, 1), --tipo-documento-faturado
			SUBSTRING(@MensagemRetorno, 346, 14), --número-identificação-faturado
			SUBSTRING(@MensagemRetorno, 360, 2), --UF-destino-faturamento
			SUBSTRING(@MensagemRetorno, 362, 8), --data-limite-restrição-tributária
			SUBSTRING(@MensagemRetorno, 370, 8), --data-última-atualização
			SUBSTRING(@MensagemRetorno, 378, 2), --tipo-operação-importação-veículo
			SUBSTRING(@MensagemRetorno, 380, 15), --número-processo-importação
			SUBSTRING(@MensagemRetorno, 395, 8), --data-baixa-transf-outro-país
			SUBSTRING(@MensagemRetorno, 403, 5), --codigo-país-transf
			SUBSTRING(@MensagemRetorno, 408, 1), --indicador-multa-exigível-RENAINF
			SUBSTRING(@MensagemRetorno, 409, 1), --indicador-comunicação-venda
			SUBSTRING(@MensagemRetorno, 410, 1), --indicador-pendência-emissão
			SUBSTRING(@MensagemRetorno, 411, 1), --indicador-restrição-RENAJUD
			SUBSTRING(@MensagemRetorno, 412, 2), --indicador-ocorrência-recall-1
			SUBSTRING(@MensagemRetorno, 414, 2), --indicador-ocorrência-recall-2
			SUBSTRING(@MensagemRetorno, 416, 2), --indicador-ocorrência-recall-3
			SUBSTRING(@MensagemRetorno, 418, 2), --indicador-recall-montadora
			SUBSTRING(@MensagemRetorno, 420, 2), --código-categoria-veículo-MRE
			SUBSTRING(@MensagemRetorno, 422, 1), --tipo-doc-proprietário-indicado
			SUBSTRING(@MensagemRetorno, 423, 14), --número-doc-proprietário-indicado
			SUBSTRING(@MensagemRetorno, 437, 8),  --data-última-atualização-MRE
			SUBSTRING(@MensagemRetorno, 445, 1), --indicador-emplacamento-eletrônico
			SUBSTRING(@MensagemRetorno, 446, 1), --origem-indicação-propriedade
			SUBSTRING(@MensagemRetorno, 447, 1), --indicador-restrição-RFB
			SUBSTRING(@MensagemRetorno, 448, 1), --indicador-placa-Veicular
			SUBSTRING(@MensagemRetorno, 449, 1) --indicador-restrições
		

END
