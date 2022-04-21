LD		=	@ld
CC		=	@gcc
EXTENSION	=	.c

SRC		=	$(wildcard $(addprefix source/, *).c)
NOM		=	$(basename $(notdir $(SRC)))
OBJ		=	$(addprefix object/, $(addsuffix .o, $(NOM)))
SRC-CRIT	=	$(wildcard $(addprefix tests/, *).c)
OBJ-CRIT	=	$(SRC-CRIT:.c=.o)

CPPFLAGS	+=	-Wall -Wextra -fPIC
LDFLAGS		+=	-Wall -Wextra -g3
CFLAGS		+=	-Iinclude -fno-builtin
CXXFLAGS	+=	-IInclude -fno-builtin
CRITFLAGS	=	-lcriterion --coverage

NAME	=	dummy_program

END		=	\033[0m
BOLD	=	\033[1m
GREY	=	\033[30m
RED		=	\033[31m
GREEN	=	\033[32m
YELLOW	=	\033[33m
BLUE	=	\033[34m
PURPLE	=	\033[35m
CYAN	=	\033[36m
WHITE	=	\033[37m

all:	$(NAME)

$(NAME):	$(OBJ)
	@$(CC) $(LDFLAGS) -o $(NAME) $(OBJ)
	@echo "$(GREEN)* * * * * COMPLETED * * * * *$(END)"

test_run:	$(OBJ-CRIT)
	@$(CC) $(CFLAGS) $(CRITFLAGS) $(OBJ-CRIT)
	@echo "$(GREEN)* * * * * COMPLETED * * * * *$(END)"
	./a.out

clean:
	@find . -type f \( -iname "*~" \) -delete
	@$(RM) $(OBJ)
	@$(RM) $(OBJ-CRIT)
	@echo "$(RED)* * * * *  CLEANED  * * * * *$(END)"

fclean:	clean
	@$(RM) $(NAME)
	@$(RM) a.out

re:	fclean all

object/%.o:	source/%$(EXTENSION)
	@$(CC) $(CFLAGS) $(LDFLAGS) -c -o $@ $<			\
	&& echo "$(GREEN)[OK]$(BOLD)" $< "$(END)"			\
	|| echo "$(RED)[KO]$(BOLD)" $< "$(END)"

.PHONY: all test_run clean fclean re
