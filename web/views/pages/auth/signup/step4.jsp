<div class="flex items-center w-full px-6 lg:w-[40%]">
    <div class="flex-1">
        <div class="text-center">
            <div class="flex justify-center mx-auto">
                <img src="https://iconape.com/wp-content/files/ww/350307/png/350307.png"  class='w-56'/>
            </div>

            <jsp:include page="/views/components/heading.jsp">
                <jsp:param name="title" value="Upload your resume"/>
                <jsp:param name="sub" value="Upload your resume to find best job opportunities based on your experience"/>
            </jsp:include>

        </div>

        <div class="mt-8">
            <form action="signup" method="POST">
                <input type="hidden" name="currentStep" value="4">

                <fieldset class="fieldset">
                    <legend class="fieldset-legend">Your CV URL
                    </legend>
                    <input type="text" class="input w-full" placeholder="Enter Your CV URL" name="cv"/>

                    <label class="label w- mt-2 text-md">
                        <input type="checkbox" checked="checked" class="checkbox" id="checked"/>
                        I sure that is my CV
                    </label>

                </fieldset>



                <div class="mt-6 text-center w-full">
                    <button type="submit" class="btn btn-secondary w-full" name="nextStep" value="5">Finish Up</button>
                </div>


            </form>

        </div>
    </div>
</div>