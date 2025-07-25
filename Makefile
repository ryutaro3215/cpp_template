CXX = c++
SRCDIR = srcs
OBJS_DIR = objs
INCLUDES = -I includes
NAME = a.out

# 通常ビルド用
SRCS = $(shell find $(SRCDIR) -name "*.cpp")
OBJS = $(SRCS:%.cpp=$(OBJS_DIR)/%.o)
CXXFLAGS = -Wall -Wextra -Werror -std=c++98

# テストビルド用（CMakeに渡す）
TEST_CXXFLAGS = -std=c++17
TEST_INCLUDES = \
  -Iincludes \
  -Ibuild/_deps/googletest-src/googletest/include \
  -Ibuild/_deps/googletest-src/googletest \
  -Ibuild/_deps/googletest-src/googlemock/include

.PHONY: all clean fclean re test runtest

all: $(NAME)

$(NAME): $(OBJS)
	@$(CXX) $(CXXFLAGS) $(OBJS) $(INCLUDES) -o $(NAME)
	@echo "Build complete: $(NAME)"

$(OBJS_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@)
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@
	@echo "Compiled: $< successfully"

clean:
	@rm -rf $(OBJS_DIR)
	@echo "Cleaned up object files"

fclean: clean
	@rm -f $(NAME)
	@echo "Cleaned up executable"

re: fclean all

# ================================
# テスト関連
# ================================

test:
	@echo "Building tests with CMake..."
	cmake -S . -B build -DCMAKE_CXX_STANDARD=17
	cmake --build build
	@echo "Tests built successfully"

runtest: test
	@echo "Running tests..."
	cd build && ctest --output-on-failure

clean_test:
	@rm -rf build
	@echo "Cleaned up test build directory"
