## 项目说明
澜盾智援 · 水域防溺水预警系统

简介：
本系统通过普通摄像头实时捕捉人体上半身姿态，根据躯干倾斜角度和手臂运动规律性判断人员状态（正常/游泳/溺水/复核）。当处于水域环境且溺水置信度 ≥0.98 时，自动触发弹射指令并记录溺水事件。支持手动水域开关、模拟测试、事件日志等。

主要功能：
- 实时人体姿态识别（MediaPipe Pose，仅依赖上半身）
- 状态分类：正常(绿)、游泳/监控(橙)、溺水报警(红)、复核(紫)
- 手动水域开关：避免非水域误报
- 溺水计数与弹射指令模拟（含距离、气压、报警上报）
- 事件日志（带时间戳）
- 手动模拟溺水/正常按钮（无需摄像头）
- 低功耗优化（限制分辨率、降低模型复杂度、跳帧处理）

运行要求：
- 操作系统：Windows / macOS / Linux
- 浏览器：Chrome / Edge / Firefox（需支持 WebRTC 和 WebGL）
- 网络：首次加载需联网获取 MediaPipe 模型
- 摄像头：任意 USB 或内置摄像头

重要：必须通过 HTTP/HTTPS 访问（不能直接双击 HTML 文件）。推荐使用本地服务器。

部署方式：

1. 本地 HTTP 服务器（最简单）
   - 安装 Python（勾选“Add Python to PATH”）
   - 在项目文件夹打开终端，执行：python -m http.server 8080
   - 浏览器访问 http://localhost:8080，允许摄像头权限

2. Windows 批处理脚本（保存为 run.bat，与 index.html 同目录）：
   @echo off
   start /b python -m http.server 8080
   timeout /t 2 >nul
   start http://localhost:8080
   pause
   taskkill /f /im python.exe

3. GitHub Pages：上传 index.html 到仓库，开启 Pages 服务

使用说明：
1. 启动系统后自动请求摄像头权限
2. 默认水域开关为“关闭”，点击顶部蓝色按钮开启（报警才生效）
3. 站在摄像头前测试不同姿态：
   - 正常站立 → 正常
   - 规律摆臂 → 游泳监控
   - 身体水平倾斜 → 溺水报警（自动触发弹射指令）
4. 也可点击“模拟溺水事件”按钮测试报警逻辑（无需摄像头）
5. 右侧面板显示溺水总数、最后弹射指令，下方事件记录区显示详细日志

常见问题：
- 摄像头被占用：关闭其他使用摄像头的软件（微信、Zoom、OBS），刷新页面重新允许权限。
- 检测不准：保证光线充足，上半身在画面内，可调整代码中的姿态阈值。
- GPU占用高：已做优化，若仍高可进一步降低摄像头分辨率或增大跳帧数。
- 直接双击 HTML 无法使用摄像头：这是浏览器安全策略，必须通过 localhost 或 https 访问。

扩展硬件对接：
在 index.html 中找到 simulateLaunch 函数，替换其中的内容为 WebSocket/串口/HTTP 请求，即可连接真实救生圈弹射装置、声光报警器、无人机等。

文件结构：
- index.html ：主程序（样式、逻辑、MediaPipe）
- README.txt ：本说明文件
- run.bat ：（可选）Windows 快速启动脚本

**Landun Rescue · Aquatic Anti-Drowning Early Warning System**

**Introduction:**  
This system uses a standard camera to capture upper body posture in real time, and judges personnel status (normal/swimming/drowning/review) based on torso tilt angle and arm movement patterns. When in an aquatic environment with a drowning confidence level ≥0.98, the ejection command is automatically triggered and the drowning incident is recorded. Supports manual water area switching, simulation testing, event logs, etc.

**Main Features:**
- Real‑time human pose estimation (MediaPipe Pose, upper body only)
- Status classification: normal (green), swimming/monitoring (orange), drowning alarm (red), review (purple)
- Manual water area switch: avoids false alarms outside water
- Drowning count and ejection command simulation (including distance, air pressure, alarm reporting)
- Event log (with timestamps)
- Manual drowning/normal simulation button (no camera required)
- Low‑power optimization (resolution limit, reduced model complexity, frame skipping)

**System Requirements:**
- OS: Windows / macOS / Linux
- Browser: Chrome / Edge / Firefox (WebRTC and WebGL support required)
- Network: internet connection needed for first‑time MediaPipe model loading
- Camera: any USB or built‑in camera

**Important:** Must be accessed via HTTP/HTTPS (double‑clicking the HTML file will **not** work). A local web server is recommended.

**Deployment Methods:**

1. **Local HTTP server (easiest)**  
   - Install Python (check “Add Python to PATH”)  
   - Open a terminal in the project folder and run: `python -m http.server 8080`  
   - Open browser to `http://localhost:8080` and allow camera permission

2. **Windows batch script** (save as `run.bat` in the same folder as `index.html`):  
   ```
   @echo off
   start /b python -m http.server 8080
   timeout /t 2 >nul
   start http://localhost:8080
   pause
   taskkill /f /im python.exe
   ```

3. **GitHub Pages** – upload `index.html` to a repository and enable Pages.

**Usage Instructions:**
- The system will request camera permission on startup.  
- The water area switch is **off** by default. Click the top blue button to turn it on (alarm works only when water mode is active).  
- Stand in front of the camera and try different postures:  
  - Standing normally → normal  
  - Regular arm swinging → swimming/monitoring  
  - Horizontal body tilt → drowning alarm (ejection command automatically triggered)  
- You can also click the “Simulate Drowning” button to test the alarm logic (no camera needed).  
- The right panel shows total drowning events and the last ejection command. The lower event log area displays detailed logs.

**Troubleshooting:**
- **Camera busy:** Close other camera‑using software (WeChat, Zoom, OBS) and refresh the page to re‑grant permission.  
- **Inaccurate detection:** Ensure good lighting and that the upper body is fully visible. Adjust posture thresholds in the code if necessary.  
- **High GPU usage:** Already optimised. If still high, further reduce camera resolution or increase frame skipping.  
- **Double‑clicking the HTML file doesn't work:** This is a browser security policy. You must access via `localhost` or HTTPS.

**Hardware Integration:**  
Locate the `simulateLaunch` function in `index.html` and replace its content with WebSocket, serial, or HTTP requests to connect to actual lifebuoy launcher, audible/visual alarm, drone, etc.

**File Structure:**
- `index.html` – main program (styles, logic, MediaPipe)  
- `README.txt` – this documentation  
- `run.bat` – (optional) Windows quick start script
