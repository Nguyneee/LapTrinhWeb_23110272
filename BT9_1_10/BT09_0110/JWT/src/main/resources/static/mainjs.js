window.API = (() => {
  const base = "";

  async function request(path, opts = {}, withAuth = true) {
    const headers = {
      "Content-Type": "application/json",
      ...(opts.headers || {}),
    };
    if (withAuth) {
      const token = localStorage.getItem("accessToken");
      if (token) headers["Authorization"] = `Bearer ${token}`;
    }
    const res = await fetch(base + path, { ...opts, headers });
    const text = await res.text();
    if (!res.ok) throw new Error(text || `${res.status} ${res.statusText}`);
    try {
      return JSON.parse(text);
    } catch {
      return text;
    }
  }

  return {
    login: (body) =>
      request(
        "/api/auth/login",
        { method: "POST", body: JSON.stringify(body) },
        false
      ),
    refresh: (refreshToken) =>
      request(
        "/api/auth/refresh",
        { method: "POST", body: JSON.stringify({ refreshToken }) },
        false
      ),
    get: (path, auth = true) => request(path, { method: "GET" }, auth),
  };
})();
