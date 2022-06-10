SRC = sendmoremoney

STANZAFILES = sendmoremoney.stanza 
OBJ = sendmoremoney

$(OBJ): $(STANZAFILES)
	stanza $(STANZAFILES) -o $(OBJ)
