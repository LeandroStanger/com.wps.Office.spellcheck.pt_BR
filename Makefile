.PHONY: all clean dicts

all: dicts

dicts:
	tail -n +2 locales.csv | while IFS=, read -r pt_BR dict_size dict_sha256 Dicionário em português Brasil Dicionário de verificação ortográfica para o idioma português Brasil dict_license; do \
		$(MAKE) com.wps.Office.spellcheck.pt_BR.yml \
			DICT_SIZE="dict_size" \
			DICT_SHA256="dict_sha256"; \
		$(MAKE) com.wps.Office.spellcheck.pt_BR.metainfo.xml \
			Dicionário em português Brasil="Dicionário em português Brasil" \
			Dicionário de verificação ortográfica para o idioma português Brasil="Dicionário de verificação ortográfica para o idioma português Brasil" \
			DICT_LICENSE="dict_license"; \
	done

com.wps.Office.spellcheck.%.metainfo.xml:
	sed \
		-e "s/pt_BR/$*/g" \
		-e "s/Dicionário em português Brasil/$(Dicionário em português Brasil)/g" \
		-e "s/Dicionário de verificação ortográfica para o idioma português Brasil/$(Dicionário de verificação ortográfica para o idioma português Brasil)/g" \
		-e "s/DICT_LICENSE/$(DICT_LICENSE)/g" \
		com.wps.Office.spellcheck.pt_BR.metainfo.xml.in > $@

com.wps.Office.spellcheck.%.yml:
	sed \
		-e "s/pt_BR/$*/g" \
		-e "s/@DICT_SHA256@/$(DICT_SHA256)/g" \
		-e "s/@DICT_SIZE@/$(DICT_SIZE)/g" \
		com.wps.Office.spellcheck.pt_BR.yml.in > $@

clean-manifests:
	rm -f com.wps.Office.spellcheck.pt_BR.yml

clean-metainfo:
	rm -f com.wps.Office.spellcheck.pt_BR.metainfo.xml

clean: clean-manifests clean-metainfo
