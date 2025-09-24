<div align="center">
  <img alt="grape-icon" src="https://github.com/gabriele-rizzo/qrtty/raw/refs/heads/main/assets/logo.png" height="96">
  <h1 align="center">qrtty</h1>

A simple **command-line QR code generator** written in Swift.
Prints QR codes directly to your terminal as ASCII/Unicode blocks, or saves them as images (PNG).
</div>

## 🚀 Features

* Generate QR codes from text or URLs
* Print directly in the terminal
* Save as **PNG**
* Adjustable output size (`--size`)
* Invert colors (`--invert`)
* Minimal and cross-platform

## 📦 Installation

Clone the repo and build with SwiftPM:

```bash
git clone https://github.com/yourusername/qrtty.git
cd qrtty
swift build -c release
```

Move the binary somewhere on your `$PATH`:

```bash
cp .build/release/qrtty /usr/local/bin/
```

## 💻 Usage

```bash
qrtty "Hello, world!"
```

### Print inverted QR

```bash
qrtty "https://example.com" --invert
```

### Save as PNG

```bash
qrtty "https://openai.com" -o qr.png
```

### Set custom size

```bash
qrtty "custom size QR" --size 512 -o big.png
```

<br/>

## ⚙️ Options

| Flag / Option         | Description                               | Default |
| --------------------- | ----------------------------------------- | ------- |
| `content` (argument)  | Text/URL to encode                        | –       |
| `-o, --output PATH`   | File path to save QR code                 | none    |
| `-f, --format FORMAT` | Output format: `png`                      | png     |
| `-s, --size SIZE`     | Output image size in pixels               | 256     |
| `-i, --invert`        | Invert dark/light blocks (ASCII + images) | false   |

## 🛠 Roadmap

* Add **SVG** output format
* Add **colored QR codes** in terminal
* Batch mode (generate multiple QRs from a file)

---

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.
