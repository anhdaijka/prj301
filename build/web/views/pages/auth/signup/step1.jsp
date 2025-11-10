
<div class="flex items-center w-full px-6 lg:w-[40%]">
    <div class="flex-1">
        <div class="text-center">
            <a href="/EmployeeManagement" class="flex justify-center mx-auto">
                <img src="https://iconape.com/wp-content/files/ww/350307/png/350307.png"  class='w-56'/>
            </a>

            <jsp:include page="/views/components/heading.jsp">
                <jsp:param name="title" value="Give us your information"/>
                <jsp:param name="sub" value="Please enter your personal details to set up your account and personalize your experience"/>
            </jsp:include>
        </div>


        <form action="signup" method="POST" onsubmit="return validatePasswords()">
            <input type="hidden" name="currentStep" value="1">
            <input type="hidden" name="nextStep" value="2">
            <fieldset class="fieldset">
                <legend class="fieldset-legend">Full Name *
                </legend>
                <input type="text" class="input w-full" placeholder="Enter your Full Name" name="fullname" required/>
            </fieldset>

            <fieldset class="fieldset">
                <legend class="fieldset-legend">Email *
                </legend>
                <input type="email" class="input w-full" placeholder="Your email here" name="email" required/>
            </fieldset>

            <fieldset class="fieldset">
                <legend class="fieldset-legend">Password *</legend>
                <input type="password" class="input w-full" placeholder="Type your password" id="password" name="password" required/>
            </fieldset>

            <fieldset class="fieldset">
                <legend class="fieldset-legend">Confirm Password *</legend>
                <input type="password" class="input w-full" placeholder="Type your password" id="confirmPassword" required/>
            </fieldset>

            <fieldset class="fieldset">
                <legend class="fieldset-legend text-warning">Sign Up as a *</legend>
                <select class="select validator w-full" name="roleId" required>
                    <option disabled selected value="">Choose:</option>
                    <option value="1">Job Seeker</option>
                    <option value="2">Recruiter</option>
                </select>
            </fieldset>


            <div class="mt-6 text-center">
                <button type="submit" class="btn btn-secondary w-full">Sign Up</button>
                <span id="errorMsg" class="text-error"></span><br/><br/>
            </div>

        </form>

        <p class="my-6 text-sm text-center text-gray-400">Do you already have an account? <a href="/EmployeeManagement/login" class="text-secondary focus:outline-none focus:underline hover:underline">Login</a>.</p>

    </div>
</div>

<script>
    function validatePasswords() {
        const password = document.getElementById("password").value.trim();
        const confirmPassword = document.getElementById("confirmPassword").value.trim();
        const errorMsg = document.getElementById("errorMsg");

        if (password === "" || confirmPassword === "") {
            errorMsg.textContent = "Please re-input password!";
            return false;
        }

        if (password !== confirmPassword) {
            errorMsg.textContent = "Password is not matched!";
            return false;
        }

        errorMsg.textContent = "";
        return true;
    }
</script>