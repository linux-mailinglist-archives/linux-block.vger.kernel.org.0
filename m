Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B8E9D34
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2019 15:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfJ3OMC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 30 Oct 2019 10:12:02 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34117 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJ3OMC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 10:12:02 -0400
Received: by mail-il1-f196.google.com with SMTP id a13so2270815ilp.1
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2019 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gfp1uCyEQ3/7eGpIrU6oq2vGWhaFqT3WD1Rs6Nw9uak=;
        b=lreDE975NGiTMYd4LN8kzl61kjMC88KLyYK0e1+LwtS9gpxoPGIZkDpskMbieiv6ry
         crH3liOFbPazXjcYv5VzVU+yLK4MazpepQiDh5Uwr1TnIvAm3Tu8+Jn/zCZ3pNkLh1rj
         vOfMI+o4t9zgTv4UTS3jEvkx2C1WofzjN31Kzp6EG+r51E58HDVNIp7jshM9oo0pqPRi
         eRoiLMBpAGnzdjrS/EFt0hrB883NuwsLHyj0XilULWQM83c74gYVEmZ3KJHP7Pul+h4e
         V44dacbFkscAHX8/Hap9W/guz1WsE2RlJ9cSgJ/UoNxbZ34WYARQ+jlZaO6W23m+obsz
         cB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gfp1uCyEQ3/7eGpIrU6oq2vGWhaFqT3WD1Rs6Nw9uak=;
        b=Dg+gzPJonvGUmkRx8PRAsc4Yel4laOpb/xESmMr7L6KIDGDaN7Zha6n3yI/cxaQX4g
         18BKx+KZnKsyHd5wszCN717uMZ3SqPSMnEOpKs0CM+qStQH/RzjFrtHlICsmDRsMLfKz
         cR5Z8jLX0trF9m76wM98wdeRADwmVQgIex2kytdxteBDoHKzaUyf5gJz2DuVqGW2t9rp
         0q3G5K8Q3dhF5XrQpIw36XiAUAofoIKBLtHZDJTi/MhUSWXUfVAQ0lNIGRpVeGS1DgNU
         +kvVIvfE6joj1fI2OvgoRLCCRBJOuq84K4EJFIJETONphfEV1sxciIoRI0yN9A9RJxhV
         YvqA==
X-Gm-Message-State: APjAAAWctlacy76u4Z8vWrGP0OBNTCzhXiExVQ/klDAxj/BR2uJYjbc4
        iQ9BmTOak6RxzZ63AH4IlJKH8pfZls1j2Q==
X-Google-Smtp-Source: APXvYqxCHtgU/S+peaEbfw6gunIvUCLQ8fnfnKW4gQf7NzzSO+fjCrOtU7c27OapDXB7hFmBMGHcJw==
X-Received: by 2002:a92:d845:: with SMTP id h5mr236219ilq.216.1572444721147;
        Wed, 30 Oct 2019 07:12:01 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m17sm44285ilb.5.2019.10.30.07.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 07:12:00 -0700 (PDT)
Subject: Re: [PATCH] liburing/test: fix build errors
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org
References: <1572419790-96807-1-git-send-email-joseph.qi@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d57120c0-36c9-00d5-0a46-9902266a9f6f@kernel.dk>
Date:   Wed, 30 Oct 2019 08:11:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572419790-96807-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/30/19 1:16 AM, Joseph Qi wrote:
> Fix the following errors when make:
>    error: ‘for’ loop initial declarations are only allowed in C99 mode
>    error: redeclaration of ‘i’ with no linkage

Applied, thanks.

-- 
Jens Axboe

