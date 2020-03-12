Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C718323B
	for <lists+linux-block@lfdr.de>; Thu, 12 Mar 2020 15:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCLOCg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Mar 2020 10:02:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40469 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgCLOCg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 10:02:36 -0400
Received: by mail-io1-f67.google.com with SMTP id d8so5756910ion.7
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jH56oGSL9Z6zC7W1JbGfY8gf3HjyriSV7qrcCGSAiHU=;
        b=hKpKfLj0qXV1v9witI4omyxP/KpBPV6gmlO1zZGkfcGIjRQyMo0M4YBxeO3WAcU3vg
         UGOK9IT600eLlD/mzMvHuXIg3dYdFNoecEK4d9gzQ0L9Vo1aE6h9+7fMNMNYnw0osYJg
         zJQorgngGvrOx5tq0BknxAie+66OaH7FC68EopoeRfCvYQyjJDYnIyoGvbx9Tt1lGoXr
         qmUZ1Xn/dZ2bEsXCJ7TqhAAZ4MeRhVfXYwIN/82D3Uk4b4MtWSXvspMmfrS9BSaX2oGB
         AXKpPv9uDv+jRy4QO/4S2mOuw6rnpX1HjaiesYd8DWm+Js9CQXE5wkWRWf3EFoq0W1jJ
         GNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jH56oGSL9Z6zC7W1JbGfY8gf3HjyriSV7qrcCGSAiHU=;
        b=jukkq5TTw9P9AqGS/nE0lSnYbQFc1tVN/Lph7GQHLeD51wBIA2fhdbsM/j7h0sIr7B
         yOxBySAlz6dzM3Nj8agI8ASbhy/MWzJ+yo3cZUwixN16DqR6LNESxR7/YH1b5Vza2Ub8
         rYZ+OrBxOvdc3Pbr4DbLY5vU9QbI+LX8po9YtWTnWjgZK7GU/tJRBZZe5rR2bKxV3U5X
         Vb91lgIDS0G2X4ZW5fIUMJ1B5YuE+RbZGXyIVcsdWZyaK3XMiCpoBFzTBuwypCmOesta
         S7SYn1Yt+87Pu0mnbaZvs/zj3aFGiapNOD9g/xYB8F75388sYXntx0oDonf2sugQaoc/
         9gug==
X-Gm-Message-State: ANhLgQ0T7uOQjJr9g+52XYmelMhYQfh3teP14+e/qarBhNx+HSUjEoTF
        4JPHpYarSxBffruTfDP3KyRi6j7Sy8BBTA==
X-Google-Smtp-Source: ADFU+vsAOgJG8/fsa5PFvY6crs2bcpbq0qzrtNW6w8ClQRmb9cTGTkXuYhzKeXQlqGubelvzioWbPA==
X-Received: by 2002:a02:a610:: with SMTP id c16mr7896824jam.43.1584021751369;
        Thu, 12 Mar 2020 07:02:31 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i82sm7885899ilf.32.2020.03.12.07.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:02:30 -0700 (PDT)
Subject: Re: [PATCH] blk-iocost: remove duplicated lines in comments
To:     tj@kernel.org, linux-block@vger.kernel.org
References: <20200227013845.GA14895@192.168.3.9>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <766972ee-086c-ff25-ce44-3077bee4c5f1@kernel.dk>
Date:   Thu, 12 Mar 2020 08:02:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227013845.GA14895@192.168.3.9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/26/20 6:38 PM, Weiping Zhang wrote:
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

Applied

-- 
Jens Axboe

