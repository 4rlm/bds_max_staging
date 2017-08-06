class Helper
  def err_code_finder(error)
    error_msg = "RT Error: #{error}"
    if error_msg.include?("connection refused")
      rt_error_code = "Connection Error"
    elsif error_msg.include?("undefined method")
      rt_error_code = "Method Error"
    elsif error_msg.include?("404 => Net::HTTPNotFound")
      rt_error_code = "404 Error"
    elsif error_msg.include?("TCP connection")
      rt_error_code = "TCP Error"
    else
      rt_error_code = error_msg
    end
    rt_error_code
  end
end
