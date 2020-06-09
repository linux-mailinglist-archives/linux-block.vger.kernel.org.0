Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C601E1F3D9D
	for <lists+linux-block@lfdr.de>; Tue,  9 Jun 2020 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgFIOIt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Jun 2020 10:08:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35635 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOIs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jun 2020 10:08:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id o6so10374547pgh.2
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2020 07:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CYZb8EUD2/J3ksaUTyzpHJ40LqChFke5e9mW0jUuoJg=;
        b=NcX4En3a+E8rsduAT0t4qUYw+zRqR8D5zSTADCyUK3OGbri2PlEVHFU9r2UZUGVpGT
         v2XPrGLulJaqj+Gy2XnNgAFf/+H0gvbKaP8Y74WbOsWM2r5gNFy1TNoB9Xxwq6fYYebq
         ax0uMrE66emwBP2i0y7C3MblRxVUvPxXVTo7pK2rUuX0j7gsE8jVYyH1jFYWZiOZBl1E
         fi/JES3Ll3K9S9kstXljQdUrCQO2e7svz91INmlCj9EEiAcSU54CgiN/wr9n6pFG7BqW
         t5h7XRjOIwDfEoKE27RRxTHzbS59LSkDVuPFGG4gR3rt9k7PCTHi2a/OnSoDa3kIyon9
         jn4Q==
X-Gm-Message-State: AOAM532NvoVDnP4FuH2HM3lZyfBu9rcVKFdbEzqBGrCEv2qOQQSvMWoM
        B8MoWAuibTXuOddw0eqtfI8EEg0s
X-Google-Smtp-Source: ABdhPJz83q4b9NE8wLAq3Biev8gEjnCu8w3m3TLwsLLweRCAH9BcARtnfXOy7MbvMPgjmZvp5AFRdA==
X-Received: by 2002:a63:214e:: with SMTP id s14mr12426326pgm.20.1591711727415;
        Tue, 09 Jun 2020 07:08:47 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id o13sm8945149pgs.82.2020.06.09.07.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 07:08:46 -0700 (PDT)
Subject: Re: [PATCH blktests] Restore support for running tests without prior
 test results
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org
References: <20200520165241.24798-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <8d53b2a8-c9bf-959c-52a0-bcc649151c6f@acm.org>
Date:   Tue, 9 Jun 2020 07:08:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200520165241.24798-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-20 09:52, Bart Van Assche wrote:
> This patch fixes the following runtime error:
> 
> ./check: line 245: LAST_TEST_RUN: unbound variable
> 
> Fixes: 203b5723a28e ("Show last run for skipped tests")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  check | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 0a4e539a5cd9..5151d01995ac 100755
> --- a/check
> +++ b/check
> @@ -240,9 +240,15 @@ _output_last_test_run() {
>  }
>  
>  _output_test_run() {
> +	local param_count
>  	if [[ -t 1 ]]; then
>  		# Move the cursor back up to the status.
> -		tput cuu $((${#LAST_TEST_RUN[@]} + 1))
> +		if [ -n "${LAST_TEST_RUN+set}" ]; then
> +			param_count=${#LAST_TEST_RUN[@]}
> +		else
> +			param_count=0
> +		fi
> +		tput cuu $((param_count + 1))
>  	fi
>  
>  	local status=${TEST_RUN["status"]}
> 

Omar, ping?
