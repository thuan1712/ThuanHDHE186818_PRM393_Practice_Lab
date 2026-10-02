import 'package:flutter/material.dart';

// ============================================================================
// Lab 7: Building a Signup Form with Validation & Good UX
// PRM393 - Lập trình Di động (Flutter)
// Sinh viên: Hoàng Đức Thuận - MSSV: HE186818
// Toàn bộ mã nguồn nằm gọn trong 1 file duy nhất (Single-file), hỗ trợ chạy trên
// Android Studio, VS Code, hoặc copy-paste trực tiếp vào DartPad.
// ============================================================================

void main() {
  runApp(const SignupApp());
}

class SignupApp extends StatelessWidget {
  const SignupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Form & Validation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: const SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Step 2 (Lab 7.1): GlobalKey để quản lý FormState
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text Controllers để lưu trữ và so sánh dữ liệu
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Step 5 (Lab 7.3): Quản lý FocusNode điều hướng bàn phím
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  // Trạng thái hiển thị mật khẩu (Bonus Enhancement)
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Điều khoản sử dụng (Bonus Enhancement)
  bool _agreeTerms = false;
  bool _termsError = false;

  // Step 6 (Lab 7.4): Trạng thái kiểm tra email bất đồng bộ (Async validation)
  bool _isCheckingEmail = false;

  // Trạng thái độ mạnh mật khẩu (Password Strength)
  int _passwordStrength = 0; // 0: None, 1: Weak, 2: Medium, 3: Strong

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_calculatePasswordStrength);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------------
  // Tính toán độ mạnh mật khẩu theo thời gian thực (Bonus)
  // --------------------------------------------------------------------------
  void _calculatePasswordStrength() {
    final password = _passwordController.text;
    int strength = 0;

    if (password.length >= 8) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password) && RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      strength++;
    }

    setState(() {
      _passwordStrength = strength;
    });
  }

  // --------------------------------------------------------------------------
  // Step 3 & 4 (Lab 7.2): Các hàm Validate tách biệt, rõ ràng, không trùng lặp
  // --------------------------------------------------------------------------

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }
    if (value.trim().length < 2) {
      return 'Họ và tên phải có ít nhất 2 ký tự';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập địa chỉ email';
    }
    final email = value.trim();
    // Đảm bảo chứa ít nhất ký tự '@' và '.' theo yêu cầu đề bài
    if (!email.contains('@') || !email.contains('.')) {
      return 'Email không hợp lệ (cần có @ và dấu chấm)';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Định dạng email chưa đúng (VD: example@email.com)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 8) {
      return 'Mật khẩu phải có tối thiểu 8 ký tự';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Mật khẩu phải chứa ít nhất 1 chữ số (0-9)';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng xác nhận lại mật khẩu';
    }
    if (value != _passwordController.text) {
      return 'Mật khẩu xác nhận không trùng khớp';
    }
    return null;
  }

  // --------------------------------------------------------------------------
  // Step 6 (Lab 7.4): Hàm xử lý nộp form kèm kiểm tra Async Email
  // --------------------------------------------------------------------------
  Future<void> _submitForm() async {
    // Ẩn bàn phím khi bấm submit
    FocusScope.of(context).unfocus();

    // 1. Kiểm tra validation đồng bộ trên Form
    final isFormValid = _formKey.currentState!.validate();

    // 2. Kiểm tra điều khoản sử dụng
    if (!_agreeTerms) {
      setState(() {
        _termsError = true;
      });
    } else {
      setState(() {
        _termsError = false;
      });
    }

    if (!isFormValid || !_agreeTerms) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng hoàn thiện đúng các trường thông tin bắt buộc.'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // 3. Thực hiện kiểm tra Async Email (Giả lập kiểm tra tồn tại trên Server)
    setState(() {
      _isCheckingEmail = true;
    });

    final enteredEmail = _emailController.text.trim().toLowerCase();

    // Giả lập độ trễ mạng 2 giây
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Giả lập quy tắc: Email bắt đầu bằng chữ "taken" là đã có người đăng ký
    if (enteredEmail.startsWith('taken')) {
      setState(() {
        _isCheckingEmail = false;
      });

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email "$enteredEmail" đã được sử dụng. Vui lòng chọn email khác!'),
          backgroundColor: Colors.orange[800],
          duration: const Duration(seconds: 3),
        ),
      );
      // Đặt lại con trỏ vào ô Email
      _emailFocus.requestFocus();
      return;
    }

    // 4. Đăng ký thành công!
    setState(() {
      _isCheckingEmail = false;
    });

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.green, size: 30),
            SizedBox(width: 10),
            Text('Đăng ký thành công!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tài khoản của bạn đã được khởi tạo thành công với thông tin:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Họ tên: ${_nameController.text.trim()}',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('• Email: ${_emailController.text.trim()}',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Reset lại form để người dùng có thể thử lại
              _formKey.currentState!.reset();
              _nameController.clear();
              _emailController.clear();
              _passwordController.clear();
              _confirmPasswordController.clear();
              setState(() {
                _agreeTerms = false;
                _termsError = false;
                _passwordStrength = 0;
              });
            },
            child: const Text('Hoàn tất'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Step 5: Chạm bên ngoài bàn phím để tự động ẩn bàn phím
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tạo tài khoản',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            // Ngăn ngừa lỗi tràn viền (overflow) khi bàn phím ảo xuất hiện
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              // Step 4: Kiểm tra inline ngay khi người dùng tương tác
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Giới thiệu
                  const Text(
                    'Đăng ký tài khoản mới',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Vui lòng điền đầy đủ các thông tin bên dưới để tiếp tục.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),

                  // 1. Trường Họ và Tên
                  _buildFieldLabel('Họ và tên', isRequired: true),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'VD: Hoàng Đức Thuận',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    validator: _validateName,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                  ),
                  const SizedBox(height: 18),

                  // 2. Trường Email
                  _buildFieldLabel('Địa chỉ Email', isRequired: true),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'VD: thuanhd@fpt.edu.vn',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: _validateEmail,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                  ),
                  const SizedBox(height: 18),

                  // 3. Trường Mật khẩu
                  _buildFieldLabel('Mật khẩu', isRequired: true),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Tối thiểu 8 ký tự, gồm ít nhất 1 số',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: _validatePassword,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                    },
                  ),

                  // Thanh chỉ báo độ mạnh mật khẩu (Password Strength Indicator)
                  if (_passwordController.text.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _buildPasswordStrengthBar(),
                  ],
                  const SizedBox(height: 18),

                  // 4. Trường Xác nhận Mật khẩu
                  _buildFieldLabel('Xác nhận mật khẩu', isRequired: true),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocus,
                    obscureText: _obscureConfirmPassword,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Nhập lại chính xác mật khẩu trên',
                      prefixIcon: const Icon(Icons.lock_reset_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: _validateConfirmPassword,
                    onFieldSubmitted: (_) {
                      _submitForm();
                    },
                  ),
                  const SizedBox(height: 16),

                  // 5. Checkbox Điều khoản sử dụng (Terms & Conditions)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreeTerms,
                          onChanged: (val) {
                            setState(() {
                              _agreeTerms = val ?? false;
                              if (_agreeTerms) _termsError = false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _agreeTerms = !_agreeTerms;
                              if (_agreeTerms) _termsError = false;
                            });
                          },
                          child: const Text(
                            'Tôi đồng ý với Điều khoản và Chính sách bảo mật',
                            style: TextStyle(fontSize: 13, color: Colors.black87),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_termsError) ...[
                    const SizedBox(height: 4),
                    const Text(
                      'Bạn cần đồng ý với điều khoản để tiếp tục đăng ký',
                      style: TextStyle(color: Colors.redAccent, fontSize: 12),
                    ),
                  ],

                  const SizedBox(height: 28),

                  // 6. Nút Đăng ký (Submit Button kèm Loading Spinner cho Async check)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _isCheckingEmail ? null : _submitForm,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: const Color(0xFF1E88E5),
                      ),
                      child: _isCheckingEmail
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Đang kiểm tra email...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Đăng ký tài khoản',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Widget phụ: Nhãn tiêu đề trường nhập liệu
  // --------------------------------------------------------------------------
  Widget _buildFieldLabel(String label, {bool isRequired = false}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // Widget phụ: Thanh đo độ mạnh mật khẩu (Password Strength Bar)
  // --------------------------------------------------------------------------
  Widget _buildPasswordStrengthBar() {
    Color barColor;
    String strengthText;

    switch (_passwordStrength) {
      case 1:
        barColor = Colors.redAccent;
        strengthText = 'Yếu (Cần ít nhất 8 ký tự và 1 số)';
        break;
      case 2:
        barColor = Colors.orange;
        strengthText = 'Trung bình (Nên thêm chữ hoa và ký tự đặc biệt)';
        break;
      case 3:
        barColor = Colors.green;
        strengthText = 'Mạnh (Mật khẩu an toàn)';
        break;
      default:
        barColor = Colors.grey[300]!;
        strengthText = 'Quá ngắn';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _passwordStrength / 3.0,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(barColor),
                  minHeight: 5,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              strengthText,
              style: TextStyle(
                fontSize: 11,
                color: barColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
